<template>
<SeatSelectionModal v-if="currentModal === 'seat-selection'" :outbound-seats="outboundSeats" :return-seats="returnSeats" :outbound-ticket-count="2" :return-ticket-count="2" @close="closeModal" @seat-selection="handleSeatSelection" />
<MealSelectionModal v-if="currentModal === 'meal-selection'" :isRoundTrip="isRoundTrip" @close="closeModal" />
<TaxiModal v-if="currentModal === 'taxi-selection'" @close="closeModal" />
<div>
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
                Chọn chỗ ngồi
            </template>
            <template v-slot:slogan>
                <p> <Armchair/> Chọn chỗ ngồi yêu thích của bạn.</p>
            </template>
            <template v-slot:content>
              <div class="w-full">
                <div v-if="selectedOutBound.length > 0">
                  <p class="flex">{{ storeSearFlight.getOldForm().fromCity }} <span><SendHorizontal /></span> {{ storeSearFlight.getOldForm().toCity }}</p>

                  <ul>
                    <li v-for="(item, index) in selectedOutBound" :key="index">
                      {{ item }}
                    </li>
                  </ul>
                </div>
                <div v-else>
                  <!-- Hiển thị thông báo khi selectedOutBound là mảng rỗng -->
                  <p>Ghế.</p>
                </div>
              </div>
            </template>
        </CardWithButton>
        <CardWithButton @beClicked="currentModal = 'meal-selection'">
            <template v-slot:header>
                Chọn bữa ăn
            </template>
            <template v-slot:slogan>

            </template>
            <template v-slot:content>
                
            </template>
        </CardWithButton>
        <CardWithButton @beClicked="currentModal = 'taxi-selection'">
            <template v-slot:header>
                Chọn dịch vụ đưa đón
            </template>
            <template v-slot:slogan>

            </template>
            <template v-slot:content>
                
            </template>
        </CardWithButton>
    </main>
</div>
</template>



<script setup>
import {reactive, ref} from 'vue';
import {Armchair, SendHorizontal} from 'lucide-vue-next';
import SeatSelectionModal from '@/components/composable/service/SeatSelectionModal.vue';
import MealSelectionModal from '@/components/composable/service/MealSelectionModal.vue';
import TaxiModal from '@/components/composable/service/TaxiModal.vue';
import BookingProgressBar from '@/components/composable/BookingProgressBar.vue';
import CardWithButton from '@/components/composable/card/CardWithButton.vue';
import {searchFlightStore} from '@/store/searchFlight';
import {ticketStore} from "@/store/ticket";
// Dữ liệu trong data()
const currentModal = ref('');
const selectedOutBound = ref([]);
const storeSearFlight = searchFlightStore();
// Ghế outbound và return


// Khai báo biến outboundSeats trước với giá trị mặc định là một mảng trống
let outboundSeats = reactive([]);

const fetchSelectedAircraft = async () => {
  const response = await fetch('http://localhost:8080/api/flight/public/getSeatList?flight_number=' + ticketStore().getSelectedDeparture().flightNumber, {
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
fetchSelectedAircraft()
    .then(data => {
      outboundSeats = reactive(data);
      // outboundSeats = reactive([
      //   [true, true, true, true, false, true],
      //   [false, true, true, true, true, true]
      // ]);
      console.log(data);
    })
    .catch(error => {
      console.error('Error:', error);
    });

const returnSeats = reactive([
  [true, true, true, true, false, true],
  [false, true, true, true, true, true]
]);

// Phương thức xử lý ghế đã chọn
const handleSeatSelection = ({ outbound, return: returnSeats }) => {
  console.log('Outbound seats:', outbound);
  selectedOutBound.value = outbound;
  console.log('Return seats:', returnSeats);
};

// Đóng modal
const closeModal = () => {
  currentModal.value = '';
};
</script>