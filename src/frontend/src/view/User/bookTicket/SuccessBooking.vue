<template>
<div class="min-h-screen bg-gradient-to-br from-red-50 to-orange-50 flex flex-col items-center justify-center p-4 pt-20">
    <BookingProgressBar :current-stage="3" />
    <div class="bg-white shadow-2xl rounded-2xl max-w-md w-full p-8 border border-red-100 mt-10">
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

            
            <p class="text-gray-600 mb-6">
                Cảm ơn bạn đã đặt vé. Dưới đây là thông tin đặt chỗ của bạn.
            </p>

            <div class="bg-orange-50 border border-orange-200 rounded-xl p-6 mb-6">
                <div class="flex justify-between items-center mb-4">
                    <div class="flex items-center space-x-3">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-red-500">
                            <path d="M2 16 2 10 2 16z"></path>
                            <path d="M3 12h19l-3-3 3-3H3"></path>
                        </svg>
                        <span class="font-semibold text-gray-700">Mã Đặt Chỗ</span>
                    </div>
                    <span class="text-2xl font-bold text-red-600">{{ $route.params.bookingCode }}</span>
                </div>

                <div class="border-t border-dashed border-orange-200 my-4"></div>

                <!--qr code-->
                <div class="flex justify-center">
                    <QrCode class="text-red-500 w-64 h-64"/>
                </div>
            </div>
            <button @click="downloadTicket" class="mt-6 w-full bg-red-500 text-white py-3 rounded-lg hover:bg-red-600 transition-colors font-semibold mb-10">
                Tải Vé Điện Tử
            </button>
            <router-link to="/home" class="w-full bg-white-500 text-red-500 py-3 rounded-lg hover:bg-red-600 hover:text-white transition-colors font-semibold border-2 border-red-500 p-3 mt-10">
                Về trang chủ
            </router-link >
        </div>
    </div>
</div>
</template>

  
  
<script setup>
import {
    onMounted, 
    
} from 'vue'
import BookingProgressBar from '@/components/composable/BookingProgressBar.vue'
import { QrCode } from 'lucide-vue-next';

const downloadTicket = () => {
    alert('Chức năng tải vé đang được phát triển')
}

onMounted(() => {
    document.title = 'Đặt vé thành công';
})
</script>
  
  
<style scoped>
/* You can add any additional scoped styles here if needed */
</style>
