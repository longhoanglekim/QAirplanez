<template>
  <div class="max-w-4xl mx-auto ">
    <!-- Loading state -->
    <div v-if="loading" class="bg-white rounded-lg shadow-lg p-6">
      <div class="animate-pulse space-y-4">
        <div class="h-8 bg-orange-100 rounded w-3/4"></div>
        <div class="h-4 bg-orange-100 rounded w-1/4"></div>
        <div class="space-y-3">
          <div class="h-4 bg-orange-100 rounded"></div>
          <div class="h-4 bg-orange-100 rounded"></div>
          <div class="h-4 bg-orange-100 rounded"></div>
        </div>
      </div>
    </div>

    <!-- Error state -->
    <div v-else-if="error" class="bg-white rounded-lg shadow-lg p-6">
      <div class="text-center">
        <div class="text-red-500 text-xl mb-2">{{ error }}</div>
        <button 
          @click="loadTicketFromServer" 
          class="px-4 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors"
        >
          Thử lại
        </button>
      </div>
    </div>

    <!-- Success state -->
    <div v-else-if="ticketData" class="bg-white rounded-lg shadow-lg p-6">
      <!-- Header -->
      <div class="mb-6">
        <h1 class="text-2xl font-bold text-orange-800 flex items-center gap-2 mb-2">
          <PlaneIcon class="h-6 w-6 text-orange-500" />
          Thông Tin Vé Máy Bay
        </h1>
        
        <div class="text-lg font-semibold text-orange-600 grid grid-cols-2 gap-4">
          <h2>Mã đặt vé: {{ loadData.bookingCode }}</h2>
          <h2>Loại vé: {{ ticketData.ticketType }}</h2>
        </div>
      </div>

      <!-- Outbound Flight -->
      <div class="bg-gradient-to-br from-orange-50 to-yellow-50 rounded-xl p-8 mb-8 shadow-lg">
        <div class="items-center gap-4 flex justify-between mb-6">
          <div class="flex items-center gap-3">
            <PlaneTakeoff class="h-8 w-8 text-orange-600" />
            <h2 class="text-2xl font-bold text-orange-800">
              Chuyến đi
            </h2>
          </div>
          <div class="flex items-center gap-2 rotate-12 border-2 border-orange-400 rounded-lg p-3 bg-white shadow-md">
            <p class="text-xl font-bold text-orange-800">
              {{ loadData.outboundFlight.status }}
            </p>
          </div>
        </div>
        <div class="grid md:grid-cols-2 gap-8">
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Số hiệu chuyến bay</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.outboundFlight.flightNumber }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Hạng vé</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ formatClass(loadData.outboundPassengerInfoList[0].ticketClassCode) }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Điểm khởi hành</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.outboundFlight.departAirportCode }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Điểm đến</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.outboundFlight.arrivalAirportCode }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Ngày bay</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ formatDate(loadData.outboundFlight.departTime) }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Giờ bay</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.outboundFlight.departTime.slice(11, 16) }}</div>
          </div>
        </div>
      </div>

      <!-- Return Flight (if round-trip) -->
      <div v-if="loadData.inboundFlight" class="bg-gradient-to-br from-yellow-50 to-orange-50 rounded-xl p-8 mb-8 shadow-lg">
        <div class="items-center gap-4 flex justify-between mb-6">
          <div class="flex items-center gap-3">
            <PlaneLanding class="h-8 w-8 text-orange-600" />
            <h2 class="text-2xl font-bold text-orange-800">
              Chuyến về
            </h2>
          </div>
          <div class="flex items-center gap-2 rotate-12 border-2 border-orange-400 rounded-lg p-3 bg-white shadow-md">
            <p class="text-xl font-bold text-orange-800">
              {{ loadData.inboundFlight.status }}
            </p>
          </div>
        </div>
        <div class="grid md:grid-cols-2 gap-8">
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Số hiệu chuyến bay</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.inboundFlight.flightNumber }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Hạng vé</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ formatClass(loadData.inboundPassengerInfoList[0].ticketClassCode) }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Điểm khởi hành</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.inboundFlight.departAirportCode }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Điểm đến</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.inboundFlight.arrivalAirportCode }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Ngày bay</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ formatDate(loadData.inboundFlight.departTime) }}</div>
          </div>
          <div class="bg-white p-4 rounded-lg shadow-md">
            <label class="text-lg text-orange-600 font-medium">Giờ bay</label>
            <div class="text-xl font-bold text-orange-800 mt-1">{{ loadData.inboundFlight.departTime.slice(11, 16) }}</div>
          </div>
        </div>
      </div>

       <!-- Passenger Information -->
       <div class="mb-8">
        <h2 class="text-2xl font-bold text-orange-800 flex items-center gap-3 mb-6">
          <User class="h-8 w-8 text-orange-600" />
          Thông tin hành khách
        </h2>
        <div class="space-y-6">
          <div v-for="(passenger, index) in loadData.outboundPassengerInfoList" 
               :key="index"
               class="bg-gradient-to-r from-orange-50 to-yellow-50 rounded-xl p-6 shadow-lg">
            <div class="grid md:grid-cols-2 gap-6">
              <div class="bg-white p-4 rounded-lg shadow-md">
                <label class="text-lg text-orange-600 font-medium">Họ và tên</label>
                <div class="text-xl font-bold text-orange-800 mt-1">{{ passenger.fullName }}</div>
              </div>
              <div class="bg-white p-4 rounded-lg shadow-md">
                <label class="text-lg text-orange-600 font-medium">Ngày sinh</label>
                <div class="text-xl font-bold text-orange-800 mt-1">{{ passenger.birthdate }}</div>
              </div>
              <div class="bg-white p-4 rounded-lg shadow-md">
                <label class="text-lg text-orange-600 font-medium">Số căn cước/hộ chiếu</label>
                <div class="text-xl font-bold text-orange-800 mt-1">{{ passenger.identification }}</div>
              </div>
              <div v-if="passenger.phoneNumber" class="bg-white p-4 rounded-lg shadow-md">
                <label class="text-lg text-orange-600 font-medium">Số điện thoại</label>
                <div class="text-xl font-bold text-orange-800 mt-1">{{ passenger.phoneNumber }}</div>
              </div>
              <div v-if="passenger.email" class="bg-white p-4 rounded-lg shadow-md">
                <label class="text-lg text-orange-600 font-medium">Email</label>
                <div class="text-xl font-bold text-orange-800 mt-1">{{ passenger.email }}</div>
              </div>
              <div v-if="passenger.seatCode" class="bg-white p-4 rounded-lg shadow-md">
                <label class="text-lg text-orange-600 font-medium">Chỗ ngồi</label>
                <div class="text-xl font-bold text-orange-800 mt-1">{{ passenger.seatCode }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>


      <!-- Additional Services -->
      <div>
        <h2 class="text-xl font-semibold text-orange-800 flex items-center gap-2 mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-orange-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
          Dịch vụ đi kèm
        </h2>
        <div class="grid gap-2">
          <div v-if="getService(loadData.service).taxiServices.length > 0">
            <div v-for="(s, serviceName) in getService(loadData.service)" 
                 :key="serviceName"
                 class="bg-yellow-50 text-orange-700 px-4 py-2 rounded-lg m-3">
                 <h3 class="text-xl font-bold text-orange-800 mb-4">{{ formmatServiceName(serviceName) }}</h3>
              <div v-if="serviceName === 'taxiServices'" class="space-y-3">
                <div v-for="(taxi, index) in getService(loadData.service).taxiServices" 
                     :key="index"
                     class="bg-white p-4 rounded-lg shadow-md">
                  <div class="text-lg font-medium text-orange-800">
                    {{ taxiStore.getTransferServicesById(taxi).name }}
                    <span class="font-bold text-orange-600">
                      {{ taxiStore.getTransferServicesById(taxi).price }} VND
                    </span>
                  </div>
                </div>
              </div>
              <div v-if="serviceName === 'meal'">
                <div v-if="getService(loadData.service).meal.outboundMeals">
                  <div class="text-lg font-medium text-orange-800">{{ formatMealTrip('outboundMeals') }}</div>
                  <div v-for="(meal, mealIndex) in getService(loadData.service).meal.outboundMeals" :key="mealIndex">
                    {{ mealStore.getMealById(meal).name }}: {{ meal }}: {{ mealStore.getMealById(meal).price }} VND
                  </div>
                </div>
                <div v-if="getService(loadData.service).meal.returnMeals">
                  <div>{{ formatMealTrip('returnMeals') }}</div>
                  <div v-for="(meal, mealIndex) in getService(loadData.service).meal.returnMeals" :key="mealIndex">
                    {{ mealStore.getMealById(meal).name }}: {{ meal }}: {{ mealStore.getMealById(meal).price }} VND
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div v-else>
            <div class="font-medium text-orange-800">Không có dịch vụ đi kèm</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { PlaneIcon, PlaneTakeoff, PlaneLanding,User,  } from 'lucide-vue-next';
import { useMealStore } from '@/store/mealStore';
import { useTaxiStore } from '@/store/taxiStore';

const loadData = ref(null)
const loading = ref(true)
const error = ref(null)
const mealStore = useMealStore()
const taxiStore = useTaxiStore()
console.log(taxiStore.getTransferServicesById('home-pickup'))
/**
 * {
  "bookingCode": "ZXBK96",
  "outboundFlight": {
    "flightNumber": "VN124",
    "serialNumber": "B00001",
    "departTime": "2025-01-07T10:30:00",
    "arrivalTime": "2025-01-07T10:30:00",
    "cancelTime": "2025-01-02T10:30:00",
    "departAirportCode": "BKK",
    "arrivalAirportCode": "HAN"
  },
  "inboundFlight": null,
  "adultResponseList": [
    {
      "firstName": "To",
      "lastName": "Bang",
      "ticketClassCode": "Economy",
      "birthdate": "2004-05-09",
      "bookingCode": "ZXBK96",
      "seatCode": "D-13",
      "identification": null,
      "email": "bangvoip673@gmail.com",
      "phoneNumber": "0924234388"
    },
    {
      "firstName": "To",
      "lastName": "Bang",
      "ticketClassCode": "Business",
      "birthdate": "2004-05-09",
      "bookingCode": "ZXBK96",
      "seatCode": "E-7",
      "identification": null,
      "email": "bangvoip673@gmail.com",
      "phoneNumber": "0924234388"
    }
  ],
  "childResponseList": [
    {
      "firstName": "HU",
      "lastName": "TO",
      "ticketClassCode": "Economy",
      "birthdate": "2020-09-09",
      "bookingCode": "ZXBK96",
      "seatCode": "E-13"
    },
    {
      "firstName": "HU",
      "lastName": "TO",
      "ticketClassCode": "Business",
      "birthdate": "2020-09-09",
      "bookingCode": "ZXBK96",
      "seatCode": "F-7"
    }
  ],
  "service": "{\"taxiServices\":[\"airport-pickup\",\"vip-service\"],\"meal\":{\"outboundMeals\":{\"2\":2},\"returnMeals\":{\"2\":2}}}"
}
 */
const ticketData = ref({
  ticketType: "Khứ hồi",
  departureInfo: {
    from: "Hà Nội (HAN)",
    to: "TP.HCM (SGN)",
    date: "2024-12-25",
    time: "07:30",
    flightNumber: "VN123"
  },
  returnInfo: {
    from: "TP.HCM (SGN)",
    to: "Hà Nội (HAN)",
    date: "2024-12-30",
    time: "16:45",
    flightNumber: "VN124"
  },
  passengers: [
    {
      fullName: "Nguyễn Văn A",
      birthDate: "1990-01-15",
      idNumber: "001090123456"
    },
    {
      fullName: "Trần Thị B",
      birthDate: "1992-05-20",
      idNumber: "001092789012"
    }
  ],
  additionalServices: [
    "Hành lý ký gửi 23kg",
    "Suất ăn đặc biệt",
    "Chọn chỗ ngồi"
  ]
});

const getService = (service) => {
  return JSON.parse(service)
}

const formatClass = (ticketClass) => {
  if (ticketClass === "Economy") {
    return "Phổ thông"
  } else if (ticketClass === "Business") {
    return "Thương gia"
  } else if (ticketClass === "First") {
    return "Cao cấp"
  }
  return "Không xác định"
}

const formatDate = (dateString) => {
  const options = { day: '2-digit', month: '2-digit', year: 'numeric' };
  return new Date(dateString).toLocaleDateString('vi-VN', options);
};

const formmatServiceName = (serviceName) => {
  if (serviceName === "taxiServices") {
    return "Dịch vụ taxi"
  } else if (serviceName === "meal") {
    return "Suất ăn"
  }
  return "Không xác định"
}

const formatMealTrip = (mealTrip) => {
  if (mealTrip === "outboundMeals") {
    return "Chuyến đi"
  } else if (mealTrip === "returnMeals") {
    return "Chuyến về"
  }
  return "Không xác định"
}

const loadTicketFromServer = async () => {
  console.log("loadTicketFromServer")
  loading.value = true
  error.value = null
  
  try {
    mealStore.getMealList()
    const req = {
      "bookingCode": "TPV52OH0",
      "firstName": "Tô"
    }
  const response = await fetch('http://localhost:8080/api/user/public/findTicketInfo', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }, body: JSON.stringify(req)
  })
  
  if (response.ok) {
    const res = await response.json()
    loadData.value = res
    
  } else {
    error.value = await response.text()
  }
} catch (err) {
  error.value = err
} finally {
  loading.value = false
}
}

onMounted(() => {
  document.title = "Kết quả tìm kiếm vé máy bay"
  loadTicketFromServer()
  
})
</script>
