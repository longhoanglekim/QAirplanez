<template>
<div class="max-w-4xl mx-auto p-6">
    <!-- Loading state -->
    <div v-if="loading" class="bg-white rounded-lg shadow-lg p-6">
      <div class="animate-pulse space-y-4">
        <div class="h-8 bg-gray-200 rounded w-3/4"></div>
        <div class="h-4 bg-gray-200 rounded w-1/4"></div>
        <div class="space-y-3">
          <div class="h-4 bg-gray-200 rounded"></div>
          <div class="h-4 bg-gray-200 rounded"></div>
          <div class="h-4 bg-gray-200 rounded"></div>
        </div>
      </div>
    </div>

    <!-- Error state -->
    <div v-else-if="error" class="bg-white rounded-lg shadow-lg p-6">
      <div class="text-center">
        <div class="text-red-500 text-xl mb-2">{{ error }}</div>
        <button @click="fetchTicketData" 
                class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors">
          Thử lại
        </button>
      </div>
    </div>

    <!-- Success state -->
    <div v-else-if="ticketData" class="bg-white rounded-lg shadow-lg p-6">
      <!-- Header -->
      <div class="mb-6">
        <h1 class="text-2xl font-bold text-gray-800 flex items-center gap-2 mb-2">
          <PlaneIcon class="h-6 w-6" />
          Thông Tin Vé Máy Bay
        </h1>
        
        <div class="text-lg font-semibold text-blue-600 grid grid-cols-2 gap-4">
          <h2>Mã đặt vé: {{ loadData.bookingCode }}</h2>
          <h2>Loại vé: {{ ticketData.ticketType }}</h2>
        </div>
      </div>

      <!-- Chuyến đi -->
      <div class="bg-gray-50 rounded-lg p-6 mb-6">
        <h2 class="text-xl font-semibold text-gray-800 mb-4">
          <PlaneTakeoff class="h-6 w-6" />
          Chuyến đi
        </h2>
        <div class="grid md:grid-cols-2 gap-6">
          <div class="col-span-2">
            <label class="text-sm text-gray-500">Số hiệu chuyến bay</label>
            <div class="font-medium text-gray-800">{{ loadData.outboundFlight.flightNumber }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Điểm khởi hành</label>
            <div class="font-medium text-gray-800">{{ loadData.outboundFlight.departCityName }}({{ loadData.outboundFlight.departAirportCode }})</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Điểm đến</label>
            <div class="font-medium text-gray-800">{{ loadData.outboundFlight.arrivalCityName }}({{ loadData.outboundFlight.arrivalAirportCode }})</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Ngày bay</label>
            <div class="font-medium text-gray-800">{{ formatDate(loadData.outboundFlight.departTime) }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Giờ bay</label>
            <div class="font-medium text-gray-800">{{ loadData.outboundFlight.departTime.slice(11, 16) }}</div>
          </div>
          
        </div>
      </div>

      <!-- Chuyến về (nếu là vé khứ hồi) -->
      <div v-if="loadData.inboundFlight" class="bg-gray-50 rounded-lg p-6 mb-6">
        <h2 class="text-xl font-semibold text-gray-800 mb-4">
          <PlaneLanding class="h-6 w-6" />
          Chuyến về
        </h2>
        <div class="grid md:grid-cols-2 gap-6">
          <div class="col-span-2">
            <label class="text-sm text-gray-500">Số hiệu chuyến bay</label>
            <div class="font-medium text-gray-800">{{ ticketData.returnInfo.flightNumber }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Điểm khởi hành</label>
            <div class="font-medium text-gray-800">{{ ticketData.returnInfo.from }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Điểm đến</label>
            <div class="font-medium text-gray-800">{{ ticketData.returnInfo.to }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Ngày bay</label>
            <div class="font-medium text-gray-800">{{ formatDate(ticketData.returnInfo.date) }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Giờ bay</label>
            <div class="font-medium text-gray-800">{{ ticketData.returnInfo.time }}</div>
          </div>
          
        </div>
      </div>

      <!-- Thông tin hành khách -->
      <div class="mb-6">
        <h2 class="text-xl font-semibold text-gray-800 flex items-center gap-2 mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
          </svg>
          Thông tin hành khách
        </h2>
        <div class="space-y-4">
          <div v-for="(passenger, index) in ticketData.passengers" 
               :key="index"
               class="bg-gray-50 rounded-lg p-4">
            <div class="grid md:grid-cols-2 gap-4">
              <div>
                <label class="text-sm text-gray-500">Họ và tên</label>
                <div class="font-medium text-gray-800">{{ passenger.fullName }}</div>
              </div>
              <div>
                <label class="text-sm text-gray-500">Ngày sinh</label>
                <div class="font-medium text-gray-800">{{ formatDate(passenger.birthDate) }}</div>
              </div>
              <div>
                <label class="text-sm text-gray-500">Số định danh</label>
                <div class="font-medium text-gray-800">{{ passenger.idNumber }}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Dịch vụ đi kèm -->
      <div>
        <h2 class="text-xl font-semibold text-gray-800 flex items-center gap-2 mb-4">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
          </svg>
          Dịch vụ đi kèm
        </h2>
        <div class="grid gap-2">
          <div v-for="(service, index) in ticketData.additionalServices" 
               :key="index"
               class="bg-blue-50 text-blue-700 px-4 py-2 rounded-lg">
            {{ service }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { PlaneIcon, PlaneTakeoff, PlaneLanding } from 'lucide-vue-next';

const loadData = ref(null)
const loading = ref(true)
const error = ref(null)

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

const formatDate = (dateString) => {
  const options = { day: '2-digit', month: '2-digit', year: 'numeric' };
  return new Date(dateString).toLocaleDateString('vi-VN', options);
};

const loadTicketFromServer = async () => {
  console.log("loadTicketFromServer")
  loading.value = true
  error.value = null
  try {
    const req = {
      "bookingCode": "ZXBK96",
      "firstName": "To"
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
    console.log(loadData.value)
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