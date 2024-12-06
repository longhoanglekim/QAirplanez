<template>
<div class="bg-gradient-to-br from-orange-50 to-red-100 img bg-cover bg-center p-4 border-b-4 border-indigo-500">
    <div class=" search-result  text-emerald-950 bg-white text-xl font-bold uppercase text-center p-5 shadow-lg rounded-lg w-72 mx-auto m-20">
        Kết quả tìm kiếm
    </div>
</div>

<div class="container mx-auto px-4 pb-6 rounded-bl-lg rounded-br-lg bg-gradient-to-br from-orange-50 to-red-100 ">
    <div class="place-items-center mb-2">
        <button class="place-items-center rounded-b-full bg-orange-400 px-6 uppercase font-bold text-sm text-slate-800">
            Thay đổi
            <ChevronDown :class="{'rotate-180' : showingSearchBox}" @click="toggleSearchBox" class="ease-in-out duration-300 cursor-pointer hover:text-blue-500 " />
        </button>
    </div>
    <div class="transition-all duration-500 ease-in-out relative place-items-center"
          :class="showingSearchBox ? 'max-h-screen opacity-100 p-4': 'max-h-0 opacity-0 p-0'">
        <FlightSearch @search-flight="handleReSearch"/>
    </div>

    <!-- Phần tiêu đề và lọc -->
    <div class=" mb-6 bg-white shadow-md max-w-4xl rounded-lg p-4 z-20 mx-auto">
        <div class="flex flex-col md:flex-row justify-between items-center space-y-4 md:space-y-0">
            <div class="flex items-center space-x-4">
                <div class="flex items-center">
                    <span class="text-2xl font-bold text-red-500 mr-2">Các vé chuyến:</span>
                    <span class="text-2xl font-bold text-red-500 mr-2">{{ departureCode }}</span>
                    <MoveRight class="text-red-500" />
                    <span class="text-2xl font-bold text-red-500 ml-2">{{ arrivalCode }}</span>
                </div>
                <span class="text-orange-500">Tìm được: {{ tickets.length }} chuyến bay</span>
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
<div class="fixed bottom-0 left-0 right-0 z-50 flex items-center justify-center py-4">
    <selecting-ticket departure-time="08:30 AM" arrival-time="10:45 AM" price="$250.00"></selecting-ticket>
</div>
</template>

<script setup>
import FlightSearch from '@/components/User/FlightSearch.vue'
import FlightTicket from '@/components/composable/ticket/FlightTicket.vue';
import SelectingTicket from '@/components/composable/ticket/SelectingTicket.vue';
import {
    useRouter
} from 'vue-router';
import {
    searchFlightStore
} from '@/store/searchFlight';
import {
    ticketStore
} from '@/store/ticket';
import {
    ChevronDown,
    MoveRight,

} from 'lucide-vue-next'

import {
    ref,
    computed,
    onMounted
} from 'vue'

const router = useRouter()

const storeTicket = ticketStore();
const storeSearchFlight = searchFlightStore();
// Ticket classes definition
const ticketClasses = [{
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
]

// Reactive state
const sortOption = ref('price')
const tickets = ref([])

const showingSearchBox = ref(false)
const toggleSearchBox = () => {
    showingSearchBox.value = !showingSearchBox.value
}

const userSelectTicket = async (selectedTicket) => {
    //luu ve vao store
    //TO DO
    selectedTicket.adults = storeSearchFlight.getOldForm().adults
    selectedTicket.children = storeSearchFlight.getOldForm().children
    storeTicket.saveArrivalTicket(selectedTicket)
    router.push('/booking/information/1')
}

const departureCode = ref(storeSearchFlight.getOldForm().toCity)
const arrivalCode = ref(storeSearchFlight.getOldForm().fromCity)

// Methods
const calculateFlightDuration = (ticket) => {
    const departureMinutes = convertTimeToMinutes(ticket.departureTime)
    const arrivalMinutes = convertTimeToMinutes(ticket.arrivalTime)
    return arrivalMinutes - departureMinutes
}

const convertTimeToMinutes = (timeString) => {
    const [hours, minutes] = timeString.split(':').map(Number)
    return hours * 60 + minutes
}

const getListTicket = async (departureDate) => {
    const req = JSON.stringify({
        departureCode: departureCode.value,
        arrivalCode: arrivalCode.value,
        expectedDepartureTime: departureDate + ' 00:00',
        expectedArrivalTime: null,
        numOfTicket: storeSearchFlight.getOldForm().adults + storeSearchFlight.getOldForm().children
    })

    await fetch('http://localhost:8080/api/flight/public/findFlight', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: req
        })
        .then(response => response.json())
        .then(data => {
            tickets.value = data.map(flight => ({
                ...flight,
                basePrice: 250000,
                selectedClass: null
            }))
        })
        .catch(error => {
            console.error('Lỗi:', error);
        });
}

// Computed property
const filteredAndSortedTickets = computed(() => {
    let result = [...tickets.value]

    // Sorting
    switch (sortOption.value) {
        case 'price':
            result.sort((a, b) => a.basePrice - b.basePrice)
            break
        case 'duration':
            result.sort((a, b) => calculateFlightDuration(a) - calculateFlightDuration(b))
            break
        case 'departure':
            result.sort((a, b) => convertTimeToMinutes(a.departureTime) - convertTimeToMinutes(b.departureTime))
            break
    }

    return result
})

const handleReSearch = () => {
    router.push('/booking/avaibility/1')
}

// Lifecycle hook
onMounted(() => {
    getListTicket(storeSearchFlight.getOldForm().returnDate)
})
</script>

<style scoped>
.img {
    background-image: url("../../../assets/destination/3.jpg");
}
</style>
