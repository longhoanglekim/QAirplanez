<template>

<div>
  <SeatSelectionModal v-if="currentModal === 'seat-selection'" 
    :key="(outboundSeats, returnSeats)"
    :outbound-seats="outboundSeats" 
    :return-seats="returnSeats" 
    :outbound-ticket-count="adultsLength + childrenLength"
    :return-ticket-count="adultsLength + childrenLength"
    :selected-outbound-seats="seatSelectedOutBound"
    :selected-return-seats="seatSelectedReturn"
    @close="closeModal" 
    @seat-selection="handleSeatSelection" />
  <MealSelectionModal v-if="currentModal === 'meal-selection'" 
    :isRoundTrip="isRoundTrip()" 
    :maxTickets="adultsLength + childrenLength"
    :key="(mealSelectedOutBound, mealSelectedReturn)"
    :propOutboundMeals="mealSelectedOutBound"
    :propReturnMeals="mealSelectedReturn"
    :meals="mealList"
    @close="closeModal" 
    @confirm="handleMealConfirm" />
  <TaxiModal v-if="currentModal === 'taxi-selection'" 
    :services="taxiSelected"
    :key="taxiSelected"
    @taxi-selection="handleTaxiSelection"
    @close="closeModal" />
    <header class="mt-20">
        <BookingProgressBar class="mx-auto" :current-stage="2" />
    </header>
    <main class="flex flex-col text-left bg-slate-100 mx-4 lg:mx-32 rounded-xl" >
        <div>
            <h1 class="text-red-400 text-2xl text-center font-bold rounded-lg p-4 w-5/6 mx-auto translate-y-1/2">
                Dịch vụ đi kèm...
            </h1>
        </div>
        <CardWithButton @beClicked="currentModal = 'seat-selection'">
            <template v-slot:header>
              <div class="flex items-center justify-center">
                <Armchair class="h-8 w-8"/> Chọn chỗ ngồi
              </div>
            </template>
            <template v-slot:slogan>
                <p>Chọn chỗ ngồi yêu thích của bạn.</p>
                <p>50.000 VNĐ/chỗ</p>
            </template>
            <template v-slot:content>
              <div class="w-full ">
                <div v-if="seatSelectedOutBound.length > 0 || (seatSelectedReturn && seatSelectedReturn.length > 0)"
                  class="grid grid-cols-2"
                >
                  <div >
                    <p v-if="seatSelectedOutBound.length > 0" class="flex">
                      {{ storeSearFlight.getOldForm().fromCityName }} 
                      <span class="mx-5"><MoveRight /></span> 
                      {{ storeSearFlight.getOldForm().toCityName }}
                    </p>
                    <ul >
                      <li v-for="(item, index) in seatSelectedOutBound" :key="index">
                        {{ item }}
                      </li>
                    </ul>
                  </div>
                  <div>
                    <p v-if="seatSelectedReturn && seatSelectedReturn.length > 0" class="flex">
                      {{ storeSearFlight.getOldForm().toCityName }} 
                      <span class="mx-5"><MoveRight /></span> 
                      {{ storeSearFlight.getOldForm().fromCityName }}
                    </p>
                    <ul>
                      <li v-for="(item, index) in seatSelectedReturn" :key="index">
                        {{ item }}
                      </li>
                    </ul>
                  </div>
                </div>
                <div v-else>
                  <!-- Hiển thị thông báo khi selectedOutBound là mảng rỗng -->
                  <p>Ghế của bạn.</p>
                </div>
              </div>
            </template>
        </CardWithButton>
        <CardWithButton @beClicked="currentModal = 'meal-selection'">
            <template v-slot:header>
                <div class="flex items-center justify-center">
                  <Soup class="h-8 w-8"/> Chọn bữa ăn
                </div>
            </template>
            <template v-slot:slogan>
              <p>Chọn món ăn yêu thích của bạn.</p>
            </template>
            <template v-slot:content>
              <p>Có rất nhiều loại món ăn hấp dẫn đang chờ bạn thưởng thức</p>
            </template>
        </CardWithButton>
        <CardWithButton @beClicked="currentModal = 'taxi-selection'">
            <template v-slot:header>
                <div class="flex items-center justify-center">
                  <CarTaxiFront class="h-8 w-8"/> Chọn dịch vụ đưa đón
                </div>
            </template>
            <template v-slot:slogan>
              <p>Lựa chọn dịch vụ phù hợp với bạn.</p>
            </template>
            <template v-slot:content>
                <p>Có rất nhiều dịch vụ hấp dẫn đang chờ đón bạn</p>
            </template>
        </CardWithButton>

        <div class="flex flex-col justify-center items-center mt-10 text-center bg-amber-50 shadow-2xl m-5 rounded-xl p-5">
          <div class="flex text-xl font-bold text-orange-500">
            <p>Tổng tiền cộng thêm: {{ formatCurrency(getPrice()) }}</p>
          </div>
          <button
              class="bg-orange-400 border-amber-300 min-w-32 text-white px-4 py-2 w-[10%] rounded-md hover:bg-orange-600 shadow-sm m-5"
              type="button"
              :disabled="submitting"
              @click="handleSubmit"
          >
            Xác nhận
          </button>
        </div>

    </main>
</div>
</template>



<script setup>
import {onMounted, ref} from 'vue';
import {Armchair,  Soup, CarTaxiFront, MoveRight} from 'lucide-vue-next';
import { formatCurrency } from '@/helper/currency';
import SeatSelectionModal from '@/components/composable/service/SeatSelectionModal.vue';
import MealSelectionModal from '@/components/composable/service/MealSelectionModal.vue';
import TaxiModal from '@/components/composable/service/TaxiModal.vue';
import BookingProgressBar from '@/components/composable/BookingProgressBar.vue';
import CardWithButton from '@/components/composable/card/CardWithButton.vue';
import {searchFlightStore} from '@/store/searchFlight';
import {ticketStore} from "@/store/ticket";
import {useMealStore} from "@/store/mealStore";
import { useRouter } from 'vue-router';
const router = useRouter();
// Dữ liệu trong data()
const currentModal = ref('');
const seatSelectedOutBound = ref([]);
const seatSelectedReturn = ref([]);
const mealSelectedOutBound = ref({});
const mealSelectedReturn = ref({});
const mealTotalPrice = ref(0);
const taxiSelected = ref([]);
const storeSearFlight = searchFlightStore();
const storeTicket = ticketStore();
const storeMeal = useMealStore();
// Ghế outbound và return
const storeForm = searchFlightStore()
// Reactive variables
const adultsLength = ref(storeForm.getOldForm().adults)
const childrenLength = ref(storeForm.getOldForm().children)

// Khai báo biến outboundSeats trước với giá trị mặc định là một mảng trống
const outboundSeats = ref([]);
const returnSeats = ref([]);
const mealList = ref([]);
const fetchSelectedAircraft = async (flightNumber) => {
  const response = await fetch('http://localhost:8080/api/flight/public/getSeatList?flight_number=' + flightNumber, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
    }
  });

  if (!response.ok) {
    throw new Error('Failed to fetch seat list');
  }

  return response.json();
};





// Lấy dữ liệu từ API và tạo outboundSeats khi đã có rows
fetchSelectedAircraft(storeTicket.getSelectedDeparture().flightNumber)
    .then(data => {
      outboundSeats.value = data;
      // outboundSeats = reactive([
      //   [true, true, true, true, false, true],
      //   [false, true, true, true, true, true]
      // ]);
    })
    .catch(error => {
      console.error('Error:', error);
});

if(storeSearFlight.getOldForm().ticketType === 'round-trip'){
  fetchSelectedAircraft(storeTicket.getSelectedArrival().flightNumber)
    .then(data => {
      returnSeats.value = data;
    })
    .catch(error => {
      console.error('Error:', error);
    });
}


const handleSeatSelection = ({ outbound, returned}) => {
  seatSelectedOutBound.value = outbound;
  seatSelectedReturn.value = returned;
};

const handleTaxiSelection = (taxiServices) => {
  taxiSelected.value = taxiServices;
};

const handleMealConfirm = ({outboundMeals, returnMeals, totalPrice}) => {
  mealSelectedOutBound.value = outboundMeals;
  mealSelectedReturn.value = returnMeals;
  mealTotalPrice.value = totalPrice;
}

// Đóng modal
const closeModal = () => {
  currentModal.value = '';
};


const submitting = ref(false)
const handleSubmit = async () => {
  submitting.value = true
  const allService = JSON.stringify({
    taxiServices: taxiSelected.value.map(service => service.id),
    meal: {outboundMeals: mealSelectedOutBound.value, returnMeals: mealSelectedReturn.value},
  })

  const passengerInfoList = storeTicket.getPassengerInformation(seatSelectedOutBound.value, seatSelectedReturn.value)
  const departFlightNumber = storeTicket.getSelectedDeparture().flightNumber
  const returnFlightNumber = (storeSearFlight.getOldForm().ticketType === 'round-trip') ? storeTicket.getSelectedArrival().flightNumber : null

  //load dât
  const data = {  
    allService,
    passengerInfoList,
    totalPrice: getPrice() + storeTicket.getTicketPrice()
  }
  const bookingLink = 'http://localhost:8080/api/user/public/bookFlight?depart_flight_number=' 
  + departFlightNumber 
  + (returnFlightNumber && returnFlightNumber !== '' ? '&return_flight_number=' + returnFlightNumber : '')
  console.log('bookingLink', bookingLink)
  const response = await fetch(bookingLink, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data)  
  });

  if(!response.ok){
    throw new Error('Failed to book flight');
  }

  const result = await response.text()
  
  submitting.value = false
  storeSearFlight.clear()
  storeTicket.clear()
  router.push('/booking/information/3/' + result); 
};




const getPrice = () => {
  const seatPrice = 55000 * (seatSelectedOutBound.value.length + (seatSelectedReturn.value ? seatSelectedReturn.value.length : 0))
  const taxiPrice = (taxiSelected.value.reduce((total, service) => total + service.price, 0))
  return seatPrice + taxiPrice + mealTotalPrice.value
}

const isRoundTrip = () => {
  return storeSearFlight.getOldForm().ticketType === 'round-trip'
}
onMounted(async () => {
  document.title = 'Dịch vụ đi kèm';
  mealList.value = await storeMeal.getMealList();
})
</script>
