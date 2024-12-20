<template>
  <div class="max-w-4xl mx-auto p-6">
    <div class="bg-white rounded-lg shadow-lg p-6">
      <!-- Header -->
      <div class="mb-6">
        <h1 class="text-2xl font-bold text-gray-800 flex items-center gap-2 mb-2">
          
          <PlaneIcon class="h-6 w-6" />
          Thông Tin Vé Máy Bay
        </h1>
        <div class="text-lg font-semibold text-blue-600">
          {{ ticketData.ticketType }}
        </div>
      </div>

      <!-- Chuyến đi -->
      <div class="bg-gray-50 rounded-lg p-6 mb-6">
        <h2 class="text-xl font-semibold text-gray-800 mb-4 flex">
          <PlaneTakeoff class="h-6 w-6 mr-4" />
          Chuyến đi
        </h2>
        <div class="grid md:grid-cols-2 gap-6">
          <div>
            <label class="text-sm text-gray-500">Điểm khởi hành</label>
            <div class="font-medium text-gray-800">{{ ticketData.departureInfo.from }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Điểm đến</label>
            <div class="font-medium text-gray-800">{{ ticketData.departureInfo.to }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Ngày bay</label>
            <div class="font-medium text-gray-800">{{ formatDate(ticketData.departureInfo.date) }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Giờ bay</label>
            <div class="font-medium text-gray-800">{{ ticketData.departureInfo.time }}</div>
          </div>
          <div>
            <label class="text-sm text-gray-500">Số hiệu chuyến bay</label>
            <div class="font-medium text-gray-800">{{ ticketData.departureInfo.flightNumber }}</div>
          </div>
        </div>
      </div>

      <!-- Chuyến về (nếu là vé khứ hồi) -->
      <div v-if="ticketData.ticketType === 'Khứ hồi'" class="bg-gray-50 rounded-lg p-6 mb-6">
        <h2 class="text-xl font-semibold text-gray-800 mb-4 flex">
          <PlaneLanding class="h-6 w-6 mr-4" />
          Chuyến về
        </h2>
        <div class="grid md:grid-cols-2 gap-6">
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
          <div>
            <label class="text-sm text-gray-500">Số hiệu chuyến bay</label>
            <div class="font-medium text-gray-800">{{ ticketData.returnInfo.flightNumber }}</div>
          </div>
        </div>
      </div>

      <!-- Thongo tin hafnh khachs -->
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
import { ref } from 'vue';
import { PlaneIcon, PlaneTakeoff, PlaneLanding } from 'lucide-vue-next';

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
</script>
