<template>
<div class="max-w-4xl mx-auto p-4 bg-gradient-to-br from-orange-50 to-red-50">
    <h1 class="text-2xl font-bold mb-6 text-center text-red-800">Chọn dịch vụ chuyến bay</h1>

    <!-- Seat Selection Card -->
    <div class="bg-white shadow-md rounded-lg mb-4 border border-red-100">
        <div class="p-4 bg-red-50 border-b border-red-100 flex justify-between items-center">
            <h2 class="text-lg font-semibold text-red-800 flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-2z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-2zm0 0V5" />
                </svg>
                Ghế ngồi
            </h2>
            <button @click="openModal('seat')" class="text-red-600 hover:bg-red-100 p-2 rounded-lg">
                {{ selectedSeat || 'Chọn ghế' }}
            </button>
        </div>
    </div>

    <!-- Meal Selection Card -->
    <div class="bg-white shadow-md rounded-lg mb-4 border border-red-100">
        <div class="p-4 bg-red-50 border-b border-red-100 flex justify-between items-center">
            <h2 class="text-lg font-semibold text-red-800 flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
                </svg>
                Suất ăn
            </h2>
            <button @click="openModal('meal')" class="text-red-600 hover:bg-red-100 p-2 rounded-lg">
                {{ selectedMeals.length }} món
            </button>
        </div>
    </div>

    <!-- Luggage Selection Card -->
    <div class="bg-white shadow-md rounded-lg mb-4 border border-red-100">
        <div class="p-4 bg-red-50 border-b border-red-100 flex justify-between items-center">
            <h2 class="text-lg font-semibold text-red-800 flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                </svg>
                Hành lý
            </h2>
            <button @click="openModal('luggage')" class="text-red-600 hover:bg-red-100 p-2 rounded-lg">
                {{ selectedLuggage }} kg
            </button>
        </div>
    </div>

    <!-- Transport Service Card -->
    <div class="bg-white shadow-md rounded-lg mb-4 border border-red-100">
        <div class="p-4 bg-red-50 border-b border-red-100 flex justify-between items-center">
            <h2 class="text-lg font-semibold text-red-800 flex items-center">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 mr-2 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 17a2 2 0 11-4 0 2 2 0 014 0zM19 17a2 2 0 11-4 0 2 2 0 014 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h1M5 17a2 2 0 104 0m-4 0a2 2 0 114 0" />
                </svg>
                Dịch vụ đưa đón
            </h2>
            <button @click="openModal('transport')" class="text-red-600 hover:bg-red-100 p-2 rounded-lg">
                {{ selectedTransports.length }} dịch vụ
            </button>
        </div>
    </div>

    <!-- Total Price -->
    <div class="bg-red-100 p-4 rounded-lg text-center shadow-md">
        <h2 class="text-xl font-bold text-red-900">
            Tổng chi phí: {{ calculateTotal().toLocaleString() }}đ
        </h2>
        <button class="mt-4 w-full py-3 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors duration-300">
            Xác nhận dịch vụ
        </button>
    </div>

    <!-- Modal Container -->
    <div v-if="activeModal" class="fixed inset-0 bg-black bg-opacity-50 z-50 flex items-center justify-center" @click.self="closeModal">
        <div class="bg-white rounded-lg shadow-xl max-w-md w-full mx-4 max-h-[80vh] overflow-y-auto" @click.stop>
            <!-- Seat Modal -->
            <div v-if="activeModal === 'seat'" class="p-6">
                <h2 class="text-xl font-bold mb-4 text-red-800">Chọn vị trí ghế</h2>
                <div class="grid grid-cols-6 gap-2">
                    <button v-for="seat in seatMap" :key="seat" @click="selectSeat(seat)" class="py-2 border rounded-lg" :class="selectedSeat === seat 
                  ? 'bg-red-600 text-white' 
                  : 'hover:bg-red-50'">
                        {{ seat }}
                    </button>
                </div>
            </div>

            <!-- Meal Modal -->
            <div v-else-if="activeModal === 'meal'" class="p-6">
                <h2 class="text-xl font-bold mb-4 text-red-800">Chọn suất ăn</h2>
                <div class="space-y-4">
                    <div v-for="meal in mealOptions" :key="meal.id" class="flex items-center justify-between border-b pb-2">
                        <div>
                            <h3 class="font-semibold">{{ meal.name }}</h3>
                            <p class="text-sm text-gray-600">{{ meal.description }}</p>
                        </div>
                        <div class="flex items-center">
                            <span class="mr-2 text-orange-600">
                                {{ meal.price.toLocaleString() }}đ
                            </span>
                            <input type="checkbox" :value="meal" v-model="selectedMeals" class="form-checkbox text-red-600" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Luggage Modal -->
            <div v-else-if="activeModal === 'luggage'" class="p-6">
                <h2 class="text-xl font-bold mb-4 text-red-800">Chọn khối lượng hành lý</h2>
                <div class="space-y-4">
                    <select v-model="selectedLuggage" class="w-full p-3 border rounded-lg text-red-800">
                        <option value="0">0 kg</option>
                        <option value="12">12 kg</option>
                        <option value="20">20 kg</option>
                        <option value="30">30 kg</option>
                    </select>
                </div>
            </div>

            <!-- Transport Modal -->
            <div v-else-if="activeModal === 'transport'" class="p-6">
                <h2 class="text-xl font-bold mb-4 text-red-800">Chọn dịch vụ đưa đón</h2>
                <div class="space-y-4">
                    <div v-for="transport in transportOptions" :key="transport.id" class="flex items-center justify-between border-b pb-2">
                        <div>
                            <h3 class="font-semibold">{{ transport.name }}</h3>
                            <p class="text-sm text-gray-600">{{ transport.description }}</p>
                        </div>
                        <div class="flex items-center">
                            <span class="mr-2 text-orange-600">
                                {{ transport.price.toLocaleString() }}đ
                            </span>
                            <input type="checkbox" :value="transport" v-model="selectedTransports" class="form-checkbox text-red-600" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</template>

  
  
<script>
export default {
    data() {
        return {
            activeModal: null,
            selectedSeat: null,
            selectedMeals: [],
            selectedLuggage: 0,
            selectedTransports: [],
            seatMap: [
                'A1', 'A2', 'A3', 'A4', 'A5', 'A6',
                'B1', 'B2', 'B3', 'B4', 'B5', 'B6',
                'C1', 'C2', 'C3', 'C4', 'C5', 'C6'
            ],
            mealOptions: [{
                    id: 'com-ga',
                    name: 'Cơm gà',
                    description: 'Cơm gà chiên nước mắm',
                    price: 50000
                },
                {
                    id: 'pho',
                    name: 'Phở bò',
                    description: 'Phở bò Nam Định truyền thống',
                    price: 70000
                },
                {
                    id: 'banh-mi',
                    name: 'Bánh mì',
                    description: 'Bánh mì thịt nguội',
                    price: 30000
                }
            ],
            transportOptions: [{
                    id: 'airport-pickup',
                    name: 'Đón tại sân bay',
                    description: 'Xe đón tại sảnh quốc nội',
                    price: 200000
                },
                {
                    id: 'home-pickup',
                    name: 'Đón tại nhà',
                    description: 'Xe đón tận địa chỉ',
                    price: 300000
                },
                {
                    id: 'return-trip',
                    name: 'Đưa về',
                    description: 'Dịch vụ đưa về điểm xuất phát',
                    price: 250000
                }
            ]
        }
    },
    methods: {
        openModal(type) {
            this.activeModal = type;
        },
        closeModal() {
            this.activeModal = null;
        },
        selectSeat(seat) {
            this.selectedSeat = seat;
            this.closeModal();
        },
        calculateTotal() {
            const mealPrice = this.selectedMeals.reduce((sum, meal) => sum + meal.price, 0);
            const luggagePrice = this.selectedLuggage * 50000;
            const transportPrice = this.selectedTransports.reduce((sum, transport) => sum + transport.price, 0);

            return mealPrice + luggagePrice + transportPrice;
        }
    }
}
</script>
