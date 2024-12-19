<template>
<div class="min-h-screen bg-gradient-to-br from-red-50 to-orange-50 flex items-center justify-center p-4">
    <div class="bg-white shadow-2xl rounded-2xl max-w-md w-full p-8 border border-red-100">
        <div class="text-center">
            <!-- Success Icon -->
            <div class="flex justify-center mb-6">
                <div class="bg-green-500 text-white rounded-full p-4 inline-block">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                    </svg>
                </div>
            </div>

            <!-- Title -->
            <h1 class="text-3xl font-bold text-red-600 mb-4">
                Đăng Ký Vé Thành Công
            </h1>

            <!-- Subtitle -->
            <p class="text-gray-600 mb-6">
                Cảm ơn bạn đã đặt vé. Dưới đây là thông tin đặt chỗ của bạn.
            </p>

            <!-- Booking Details Card -->
            <div class="bg-orange-50 border border-orange-200 rounded-xl p-6 mb-6">
                <div class="flex justify-between items-center mb-4">
                    <div class="flex items-center space-x-3">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-red-500">
                            <path d="M2 16 2 10 2 16z"></path>
                            <path d="M3 12h19l-3-3 3-3H3"></path>
                        </svg>
                        <span class="font-semibold text-gray-700">Mã Đặt Chỗ</span>
                    </div>
                    <span class="text-2xl font-bold text-red-600">{{ bookingCode }}</span>
                </div>

                <div class="border-t border-dashed border-orange-200 my-4"></div>

                <!-- QR Code Placeholder -->
                <div class="flex justify-center">
                    <svg xmlns="http://www.w3.org/2000/svg" width="120" height="120" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" stroke-linecap="round" stroke-linejoin="round" class="text-red-500">
                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                        <path d="M7 10h2v4H7zm4 0h2v4h-2z"></path>
                    </svg>
                </div>
            </div>

            <!-- Passenger Details -->
            <div class="grid grid-cols-2 gap-4 text-left">
                <div>
                    <p class="text-sm text-gray-500">Hành Khách</p>
                    <p class="font-semibold text-gray-700">{{ passengerName }}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Ngày Bay</p>
                    <p class="font-semibold text-gray-700">{{ flightDate }}</p>
                </div>
            </div>

            <!-- Download Ticket Button -->
            <button @click="downloadTicket" class="mt-6 w-full bg-red-500 text-white py-3 rounded-lg hover:bg-red-600 transition-colors font-semibold">
                Tải Vé Điện Tử
            </button>
        </div>
    </div>
</div>
</template>

  
  
<script setup>
import {
    ref,
    onMounted
} from 'vue'

const bookingCode = ref('VN8745')
const passengerName = ref('Nguyễn Văn A')
const flightDate = ref('15/12/2024')

const downloadTicket = () => {
    // Implement ticket download logic here
    alert('Chức năng tải vé đang được phát triển')
}

onMounted(() => {
    document.title = 'Đặt vé thành công';
})
</script>
  
  
<style scoped>
/* You can add any additional scoped styles here if needed */
</style>
