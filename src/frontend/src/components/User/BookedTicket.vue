<template>
<div class="hoverClass mx-auto bg-white shadow-lg rounded-xl overflow-hidden border border-red-100 hover:shadow-xl transition-all duration-300 ease-in-out">
    <div class="bg-gradient-to-r from-red-600 to-orange-500 text-white p-4 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            <p class="text-lg font-bold tracking-wider">{{ seatCode }}</p>
        </div>

        <!-- Phần thông tin chuyến bay -->
        <div class="flex justify-between items-center">
            <div class="text-center w-1/2">
                <p class="text-xl font-bold text-white">{{ departureCode }}</p>
                <p class="text-sm text-white">{{ departureName }}</p>
            </div>
            <div class="flex items-center">
                <div class="w-8 h-px bg-red-300 mx-2"></div>
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
                </svg>
                <div class="w-8 h-px bg-red-300 mx-2"></div>
            </div>
            <div class="text-center w-1/2">
                <p class="text-xl font-bold text-white">{{ arrivalCode }}</p>
                <p class="text-sm text-white">{{ arrivalName }}</p>
            </div>
        </div>
        <ChevronDown class="text-white bg-orange-500 rounded-b-2xl hover:scale-125 transition-all duration-300" :class="{'rotate-180': showingInformation}" @click="toggleInfomation" />
    </div>

    <div v-if="showingInformation" class="p-4 space-y-4 relative">
        <div v-for="(passenger,index) in passengers" :key="index" class="bg-red-50 rounded-lg p-4 flex items-center justify-between mb-4">
            <div class="flex items-center space-x-4">
                <div class="bg-red-600 text-white rounded-full w-12 h-12 flex items-center justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                    </svg>
                </div>
                <div>
                    <p class="text-lg font-bold text-red-800">{{ passenger.name }}</p>
                    <p class="text-sm text-red-600">{{ passenger.identifyCode }}</p>
                </div>
            </div>
            <div class="text-right">
                <p class="text-xl font-bold text-red-600">{{ price }} VND</p>
                <p class="text-xs text-gray-500">Đã bao gồm thuế</p>
            </div>
        </div>

        <!-- Thời gian khởi hành và đến nơi -->
        <div class="grid grid-cols-2 gap-4 border-t border-red-100 pt-4">
            <div>
                <p class="text-xs text-gray-500">Khởi Hành</p>
                <p class="font-semibold text-red-700">{{ departureTime }}</p>
            </div>
            <div>
                <p class="text-xs text-gray-500">Đến Nơi</p>
                <p class="font-semibold text-red-700">{{ arrivalTime }}</p>
            </div>
        </div>

        <!-- Thông tin chuyến bay và chỗ ngồi -->
        <div class="grid grid-cols-2 gap-4 border-t border-red-100 pt-4">
            <div>
                <p class="text-xs text-gray-500">Số Hiệu</p>
                <p class="font-semibold">{{ flightNumber }}</p>
            </div>
            <div>
                <p class="text-xs text-gray-500">Chỗ ngồi</p>
                <p class="font-semibold"> <span v-for="(passenger, index) in passengers" :key="index">{{ passenger.seatPosition }} &nbsp;</span></p>
            </div>
        </div>

        <!-- Nút hủy vé -->
        <div>
            <button class="w-1/3 bg-red-600 text-white py-3 rounded-lg hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-red-500 focus:ring-opacity-50 transition-all duration-300 ease-in-out transform hover:scale-105 active:scale-95">
                Hủy Vé
            </button>
        </div>
    </div>
</div>
</template>

<script setup>
import {
    ChevronDown
} from 'lucide-vue-next';
import {
    ref
} from 'vue';
const showingInformation = ref(false)
const toggleInfomation = () => {
    showingInformation.value = !showingInformation.value
}
</script>

<script>
  export default {
      props: {
          seatCode: {
              type: String,
              default: 'ABCD123'
          },
          classType: {
              type: String,
              default: 'Hạng Phổ Thông'
          },
          departureCode: {
              type: String,
              default: 'HAN'
          },
          departureName: {
              type: String,
              default: 'Hà Nội'
          },
          arrivalCode: {
              type: String,
              default: 'SGN'
          },
          arrivalName: {
              type: String,
              default: 'Hồ Chí Minh'
          },
          departureTime: {
              type: String,
              default: '07:30 AM, 15/12/2024'
          },
          arrivalTime: {
              type: String,
              default: '09:00 AM, 15/12/2024'
          },
          flightNumber: {
              type: String,
              default: 'VN-245'
          },
          passengers: {
              type: Array,
              validator(value) {
                  // Kiểm tra mỗi phần tử trong mảng phải có các thuộc tính name và email
                  return value.every(passenger =>
                      Object.prototype.hasOwnProperty.call(passenger, 'name') && Object.prototype.hasOwnProperty.call(passenger, 'identifyCode')
                  );
              },
              default: () => [{
                      name: 'Nguyen Van A',
                      identifyCode: '00123456789',
                      seatPosition: 'A09'
                  },
                  {
                      name: 'Tran Van B',
                      identifyCode: '00123456789',
                      seatPosition: 'A09'
                  },
                  {
                      name: 'Ho Van C',
                      identifyCode: '00123456789',
                      seatPosition: 'A09'
                  },
                  {
                      name: 'Nguyen Van A',
                      identifyCode: '00123456789',
                      seatPosition: 'A09'
                  }
              ]
          },
          passengerName: {
              type: String,
              default: 'Nguyễn Văn A'
          },
          passengerIdentity: {
              type: String,
              default: '001234567890'
          },
          price: {
              type: [Number, String],
              default: '0'
          },
          seatPosition: {
              type: String,
              default: 'A49'
          }
      },
      name: 'BookedTicket',
  }
</script>
  
  
<style scoped>
@keyframes pulse {

    0%,
    100% {
        transform: scale(1);
    }

    50% {
        transform: scale(1.02);
    }
}

.hover\:animate-pulse:hover {
    animation: pulse 1s infinite;
}

.hoverClass:hover {
    box-shadow: 0 8px 10px -1px rgb(0 0 0 / 0.5), 0 2px 4px -2px rgba(0, 0, 0, 0.8);
}
</style>
