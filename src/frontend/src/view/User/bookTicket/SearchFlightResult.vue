<template>
<div class="bg-gradient-to-br from-orange-50 to-red-100 img bg-cover bg-center p-4 mb-2 border-b-4 border-indigo-500">
    <div class=" search-result  text-emerald-950 bg-white text-xl font-bold uppercase text-center p-5 shadow-lg rounded-lg w-72 mx-auto m-20">
        Kết quả tìm kiếm
    </div>
</div>

<div class="container mx-auto px-4 pb-6 relative rounded-bl-lg rounded-br-lg bg-gradient-to-br from-orange-50 to-red-100 ">
    <div class="place-items-center ab">
        <CircleChevronDown :class="{'rotate-180' : showingSearchBox}" @click="toggleSearchBox" class="ease-in-out duration-300 cursor-pointer hover:text-blue-500 " />
    </div>
    <div v-if="showingSearchBox" class="animate-fade-down animate-once place-items-center z-30">
        &nbsp;
        <FlightSearch />
        &nbsp;
    </div>

    <!-- Phần tiêu đề và lọc -->
    <div class=" mb-6 bg-white shadow-md max-w-4xl rounded-lg p-4 z-20 mx-auto">
        <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
            <div class="flex items-center space-x-4">
                <div class="flex items-center">
                    <span class="text-2xl font-bold text-red-500 mr-2">{{ departureCode }}</span>
                    <MoveRight class="text-red-500" />
                    <span class="text-2xl font-bold text-red-500 ml-2">{{ arrivalCode }}</span>
                </div>
                <span class="text-orange-500">{{ tickets.length }} chuyến bay</span>
            </div>

            <div class="flex items-center space-x-4">
                <div class="relative">
                    <select v-model="sortOption" class="appearance-none w-full pl-3 pr-10 py-2 border border-gray-300 rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500">
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
                    <button @click="toggleFilterModal" class="bg-blue-50 text-blue-600 px-3 py-2 rounded-md hover:bg-blue-100 transition flex items-center">
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
    <div v-if="filteredAndSortedTickets.length > 0" class="z-10 space-y-4">
        <FlightTicket v-for="(ticket, index) in filteredAndSortedTickets" :key="index" :ticket="ticket" :ticket-classes="ticketClasses" @selected="userSelectTicket" />
    </div>

    <div v-else class="text-center py-16 bg-white rounded-lg shadow-md">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-24 w-24 mx-auto text-gray-300 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
        </svg>
        <p class="text-xl text-orange-600 mb-4">Không tìm thấy chuyến bay phù hợp</p>
        <p class="text-sm text-gray-500">Vui lòng thử lại với tiêu chí tìm kiếm khác</p>
    </div>
</div>
</template>

    
    
<script setup>
import FlightSearch from '@/components/User/FlightSearch.vue'
import FlightTicket from '@/components/User/FlightTicket.vue'
import { searchFlightStore } from '@/store/searchFlight';
import { ticketStore } from '@/store/ticket';
import {
    CircleChevronDown,
    MoveRight
} from 'lucide-vue-next'
import {
    ref
} from 'vue';

const storeTicket = ticketStore();
const showingSearchBox = ref(false)
const toggleSearchBox = () => {
    showingSearchBox.value = !showingSearchBox.value
}
const storeSearchFlight = searchFlightStore();
const userSelectTicket = (selectedTicket) => {
    console.log('SearchFlightResult.vue')
    console.log(storeSearchFlight.getLastSearch())
    storeSearchFlight.reverseSearch()
    storeTicket.saveTicket(selectedTicket)
}

const departureCode = storeSearchFlight.getLastSearch().fromCity
const arrivalCode = storeSearchFlight.getLastSearch().toCity
</script>

<script>
export default {
    components: {
        FlightSearch,
        CircleChevronDown,
        FlightTicket
    },
    data() {
        return {
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

<style scoped>
.img {
    background-image: url("../../../assets/destination/3.jpg");
}
</style>
