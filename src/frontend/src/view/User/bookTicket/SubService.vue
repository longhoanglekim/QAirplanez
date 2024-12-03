<template>
<div class="max-w-2xl mx-auto p-6 bg-white shadow-md rounded-lg">
    <h1 class="text-2xl font-bold mb-6 text-center">Dịch vụ chuyến bay</h1>

    <!-- Seat Selection -->
    <div class="mb-6 text-left">
        <h2 class="text-xl font-semibold mb-4">Chọn ghế</h2>
        <div class="space-y-4">
            <div class="flex items-center justify-between">
                <span>Chuyến đi: SGN -> HAN</span>
                <div class="flex items-center space-x-2">
                    <button class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition" @click="openOutboundSeatSelection">
                        Chọn ghế
                    </button>
                    <span class="font-medium">Ghế: {{ outboundSeat }}</span>
                </div>
            </div>
            <div class="flex items-center justify-between">
                <span>Chuyến về: HAN -> SGN</span>
                <div class="flex items-center space-x-2">
                    <button class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition" @click="openReturnSeatSelection">
                        Chọn ghế
                    </button>
                    <span class="font-medium">Ghế: {{ returnSeat }}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Extra Baggage -->
    <div class="mb-6 text-left">
        <h2 class="text-xl font-semibold mb-4">Hành lý gửi thêm</h2>
        <div class="flex items-center space-x-4">
            <span>Chọn gói:</span>
            <select class="border rounded px-2 py-1" v-model="extraBaggage">
                <option value="">Không cần</option>
                <option value="10">10kg</option>
                <option value="20">20kg</option>
                <option value="30">30kg</option>
                <option value="40">40kg</option>
            </select>
        </div>
    </div>

    <!-- Airport Transfer -->
    <div class="mb-6 text-left">
        <h2 class="text-xl font-semibold mb-4">Đưa đón</h2>
        <div class="flex items-center space-x-2">
            <input type="checkbox" v-model="airportTransfer" class="form-checkbox h-5 w-5 text-blue-600" />
            <span>Dịch vụ đưa đón sân bay</span>
        </div>
    </div>

    <!-- Meal Selection -->
    <div class="mb-6 text-left">
        <h2 class="text-xl font-semibold mb-4">Chọn đồ ăn</h2>
        <div class="space-y-4">
            <div class="flex items-center justify-between">
                <span>Chuyến đi: SGN -> HAN</span>
                <div class="flex items-center space-x-2">
                    <button class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition" @click="openOutboundMealSelection">
                        Chọn đồ ăn
                    </button>
                    <span class="font-medium">
                        Đồ ăn: {{ outboundMeal || 'Chưa chọn' }}
                    </span>
                </div>
            </div>
            <div class="flex items-center justify-between">
                <span>Chuyến về: HAN -> SGN</span>
                <div class="flex items-center space-x-2">
                    <button class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition" @click="openReturnMealSelection">
                        Chọn đồ ăn
                    </button>
                    <span class="font-medium">
                        Đồ ăn: {{ returnMeal || 'Chưa chọn' }}
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

  
  
<script>
import {
    ref
} from 'vue'

// State variables
const outboundSeat = ref('B52')
const returnSeat = ref('A49')
const extraBaggage = ref('')
const airportTransfer = ref(false)
const outboundMeal = ref('')
const returnMeal = ref('')

// Placeholder methods for seat and meal selection
const openOutboundSeatSelection = () => {
    // TODO: Implement seat selection logic
    console.log('Open outbound seat selection')
}

const openReturnSeatSelection = () => {
    // TODO: Implement seat selection logic
    console.log('Open return seat selection')
}

const openOutboundMealSelection = () => {
    // TODO: Implement meal selection logic
    console.log('Open outbound meal selection')
}

const openReturnMealSelection = () => {
    // TODO: Implement meal selection logic
    console.log('Open return meal selection')
}
</script>
