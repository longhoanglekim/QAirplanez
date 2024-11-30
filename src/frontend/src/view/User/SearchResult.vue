<template>
<div class="container mx-auto px-4 py-6 ">
    <div class="mt-16 place-items-center">
      <FlightSearch v-if="showingSearchBox" class="mb-8"/>
      <CircleChevronDown v-if="!showingSearchBox" @click="toggleSearchBox" class="animate-bounce w-6 h-6"/>
      <CircleChevronUp v-if="showingSearchBox" @click="toggleSearchBox" class="animate-bounce w-6 h-6"/>
    </div>
    <!-- Phần tiêu đề và lọc (giữ nguyên như cũ) -->
    <div class="mb-6 bg-white shadow-md rounded-lg p-4">
      <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
        <div class="flex items-center space-x-4">
          <div class="flex items-center">
            <span class="text-2xl font-bold text-blue-600 mr-2">{{ departureCode }}</span>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7-7 7" />
            </svg>
            <span class="text-2xl font-bold text-blue-600 ml-2">{{ arrivalCode }}</span>
          </div>
          <span class="text-gray-500">{{ tickets.length }} chuyến bay</span>
        </div>

        <div class="flex items-center space-x-4">
          <div class="relative">
            <select 
              v-model="sortOption" 
              class="appearance-none w-full pl-3 pr-10 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <option value="price">Giá thấp nhất</option>
              <option value="duration">Thời gian ngắn nhất</option>
              <option value="departure">Giờ khởi hành</option>
            </select>
            <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
              <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z" />
              </svg>
            </div>
          </div>

          <div class="flex items-center space-x-2">
            <button 
              @click="toggleFilterModal" 
              class="bg-blue-50 text-blue-600 px-3 py-2 rounded-md hover:bg-blue-100 transition flex items-center"
            >
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z" />
              </svg>
              Lọc
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Danh sách vé -->
    <div v-if="filteredAndSortedTickets.length > 0" class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="(ticket, index) in filteredAndSortedTickets" :key="index" class="transform transition duration-300 hover:scale-105">
            <div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-blue-500/50">
                <!-- Phần header vé (giữ nguyên) -->
                <div class="p-4 bg-blue-600 text-white flex justify-between items-center">
                    <div class="flex items-center">
                        <span class="text-xl font-bold mr-2">{{ ticket.departureCode }}</span>
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7-7 7" />
                        </svg>
                        <span class="text-xl font-bold ml-2">{{ ticket.arrivalCode }}</span>
                    </div>
                    <div class="text-sm">{{ ticket.flightNumber }}</div>
                </div>

                <div class="p-4">
                    <!-- Thời gian bay (giữ nguyên) -->
                    <div class="flex justify-between mb-4">
                        <div>
                            <p class="text-gray-600 text-sm">Khởi hành</p>
                            <p class="font-semibold">{{ ticket.departureTime }}</p>
                            <p class="text-xs text-gray-500">{{ ticket.departureDate }}</p>
                        </div>
                        <div class="text-right">
                            <p class="text-gray-600 text-sm">Đến</p>
                            <p class="font-semibold">{{ ticket.arrivalTime }}</p>
                            <p class="text-xs text-gray-500">{{ ticket.arrivalDate }}</p>
                        </div>
                    </div>

                    
                    <div class="mb-4">
                        <p class="text-gray-600 text-sm mb-2">Chọn hạng vé</p>
                        <div class="flex space-x-2">
                            <button v-for="(ticketClass, index) in ticketClasses" :key="index" 
                            @click="ticket.selectedClass = (ticket.selectedClass === ticketClass.value ? null: ticketClass.value)" 
                            :class="[
                                  'px-3 py-1 rounded-full text-sm transition-colors duration-200 border',
                                  ticket.selectedClass === ticketClass.value 
                                    ? 'bg-blue-600 text-white border-blue-600' 
                                    : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-100'
                  ]">
                                {{ ticketClass.label }}
                            </button>
                        </div>
                    </div>

                    <!-- Thông tin hành lý -->
                    <div v-if="ticket.selectedClass" class="bg-blue-50 p-3 rounded-lg mb-4">
                        <div class="flex justify-between">
                            <div>
                                <p class="text-gray-600 text-xs">Hành lý xách tay</p>
                                <p class="font-medium text-sm">
                                    {{ getBaggageInfo(ticket.selectedClass).carryon }} kg
                                </p>
                            </div>
                            <div>
                                <p class="text-gray-600 text-xs">Hành lý ký gửi</p>
                                <p class="font-medium text-sm">
                                    {{ getBaggageInfo(ticket.selectedClass).checkedbaggage }} kg
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Giá và nút chọn -->
                    <div class="bg-blue-50 p-3 rounded-lg mb-4">
                        <div class="flex justify-between items-center">
                            <div>
                                <p class="text-gray-600 text-xs">Giá từ</p>
                                <p class="font-bold text-lg text-blue-600">
                                    {{ calculateTicketPrice(ticket) }}
                                </p>
                            </div>
                            <div class="text-right">
                                <p class="text-gray-600 text-xs">Thời gian bay</p>
                                <p class="font-medium text-sm">
                                    {{ calculateFlightDuration(ticket) }} phút
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="flex space-x-2">
                        <button :disabled="!ticket.selectedClass" class="flex-1 px-4 py-2 rounded-lg transition-colors 
                  text-white font-semibold
                  disabled:bg-gray-400 
                  bg-green-500 hover:bg-green-600">
                            Chọn chuyến
                        </button>
                        <button class="bg-gray-200 text-gray-700 px-3 py-2 rounded-lg hover:bg-gray-300 transition-colors">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div v-else class="text-center py-16 bg-white rounded-lg shadow-md">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-24 w-24 mx-auto text-gray-300 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
        <p class="text-xl text-gray-600 mb-4">Không tìm thấy chuyến bay phù hợp</p>
        <p class="text-sm text-gray-500">Vui lòng thử lại với tiêu chí tìm kiếm khác</p>
    </div>
</div>
</template>

<script setup>
import FlightSearch from '@/components/User/FlightSearch.vue'
import { CircleChevronDown, CircleChevronUp } from 'lucide-vue-next'
import { ref } from 'vue';

const showingSearchBox = ref(false)
const toggleSearchBox = () => {
  showingSearchBox.value = !showingSearchBox.value
}
</script>

<script>
export default {
  components: { FlightSearch ,
    CircleChevronDown, CircleChevronUp
  },
    data() {
        return {
            departureCode: 'HAN',
            arrivalCode: 'SGN',
            sortOption: 'price',
            showFilterModal: false,
            ticketClasses: [{
                    value: 'economy',
                    label: 'Economy',
                    priceMultiplier: 1,
                    baggageInfo: {
                        carryon: 7,
                        checkedbaggage: 20
                    }
                },
                {
                    value: 'business',
                    label: 'Business',
                    priceMultiplier: 2.5,
                    baggageInfo: {
                        carryon: 10,
                        checkedbaggage: 30
                    }
                },
                {
                    value: 'first',
                    label: 'First Class',
                    priceMultiplier: 4,
                    baggageInfo: {
                        carryon: 12,
                        checkedbaggage: 40
                    }
                }
            ],
            tickets: [{
                    departureCode: 'HAN',
                    arrivalCode: 'SGN',
                    flightNumber: 'VN123',
                    departureTime: '10:30',
                    departureDate: '15 Dec 2024',
                    arrivalTime: '12:45',
                    arrivalDate: '15 Dec 2024',
                    basePrice: 250000,
                    selectedClass: null
                },
                {
                    departureCode: 'HAN',
                    arrivalCode: 'SGN',
                    flightNumber: 'VN456',
                    departureTime: '14:15',
                    departureDate: '15 Dec 2024',
                    arrivalTime: '16:30',
                    arrivalDate: '15 Dec 2024',
                    basePrice: 300000,
                    selectedClass: null
                },
                {
                    departureCode: 'HAN',
                    arrivalCode: 'SGN',
                    flightNumber: 'VN789',
                    departureTime: '20:00',
                    departureDate: '15 Dec 2024',
                    arrivalTime: '22:15',
                    arrivalDate: '15 Dec 2024',
                    basePrice: 220000,
                    selectedClass: null
                }, {
                    departureCode: 'HAN',
                    arrivalCode: 'SGN',
                    flightNumber: 'VN123',
                    departureTime: '10:30',
                    departureDate: '15 Dec 2024',
                    arrivalTime: '12:45',
                    arrivalDate: '15 Dec 2024',
                    basePrice: 250000,
                    selectedClass: null
                }
            ]
        }
    },
    computed: {
        filteredAndSortedTickets() {
            let result = [...this.tickets]

            // Sắp xếp
            switch (this.sortOption) {
                case 'price':
                    result.sort((a, b) => a.basePrice - b.basePrice)
                    break
                case 'duration':
                    result.sort((a, b) => this.calculateFlightDuration(a) - this.calculateFlightDuration(b))
                    break
                case 'departure':
                    result.sort((a, b) => this.convertTimeToMinutes(a.departureTime) - this.convertTimeToMinutes(b.departureTime))
                    break
            }

            return result
        }
    },
    methods: {
        getBaggageInfo(classType) {
            const ticketClass = this.ticketClasses.find(cls => cls.value === classType)
            return ticketClass ? ticketClass.baggageInfo : null
        },
        calculateTicketPrice(ticket) {
            if (!ticket.selectedClass) return this.formatPrice(ticket.basePrice)

            const ticketClass = this.ticketClasses.find(cls => cls.value === ticket.selectedClass)
            const price = ticket.basePrice * ticketClass.priceMultiplier

            return this.formatPrice(price)
        },
        formatPrice(price) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(price)
        },
        calculateFlightDuration(ticket) {
            const departureMinutes = this.convertTimeToMinutes(ticket.departureTime)
            const arrivalMinutes = this.convertTimeToMinutes(ticket.arrivalTime)
            return arrivalMinutes - departureMinutes
        },
        convertTimeToMinutes(timeString) {
            const [hours, minutes] = timeString.split(':').map(Number)
            return hours * 60 + minutes
        },
        toggleFilterModal() {
            this.showFilterModal = !this.showFilterModal
        }
    }
}
</script>
