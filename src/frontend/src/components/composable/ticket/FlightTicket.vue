
<template>
     <div class="max-w-4xl mx-auto p-6 bg-white shadow-lg rounded-lg " >
        <!-- Header with Flight Number -->
        <div class="relative flex justify-between items-center mb-4">
             <div class=" transform w-fit h-10 text-sm text-gray-500">
                Số hiệu chuyến bay: 
                <div class="font-semibold text-red-600">{{ ticket.flightNumber }}</div>
            </div>
            <div class="text-sm font-bold text-gray-700">
                {{ ticket.departureDate }}
            </div>
        </div>

        <div class="flex justify-between items-center mb-4">
            <div>
                <h1 class="text-xl font-semibold">{{ ticket.departureAirport }}</h1>
                <p class="text-2xl font-bold text-gray-600">{{ ticket.departureTime }}</p>
            </div>
            <div class="flex items-center space-x-4 transition-all duration-300 ease-in-out transform hover:scale-105 hover:shadow-lg">
                <div class="text-gray-500 text-sm text">{{ calculateFlightDuration }} phút</div>
            </div>
            <div class="text-right">
                <h1 class="text-xl font-semibold">{{ ticket.arrivalAirport }}</h1>
                <p class="text-2xl font-bold text-gray-600">{{ ticket.arrivalTime }}</p>
            </div>
        </div>

        <div class="grid grid-cols-3 gap-3">
            <div 
                v-for="(ticketClass, index) in ticketClasses" 
                :key="index" 
                class="border rounded-lg p-2 text-center cursor-pointer transition-all duration-300 ease-in-out transform hover:scale-105 hover:shadow-lg relative"
                :class="{
                    'border-green-600 hover:bg-green-50': ticketClass.value === 'economy', 
                    'bg-green-50' : localTicket.selectedClass === 'economy' && ticketClass.value === 'economy',
                    'border-blue-600 hover:bg-blue-50': ticketClass.value === 'business', 
                    'bg-blue-50' : localTicket.selectedClass === 'business' && ticketClass.value === 'business',
                    'border-red-600 hover:bg-red-50': ticketClass.value === 'first', 
                    'bg-rose-50' : localTicket.selectedClass === 'first' && ticketClass.value === 'first',
                    ' scale-105 shadow-lg': localTicket.selectedClass === ticketClass.value
                }"
                @click="selectTicketClass(ticketClass.value)"
                @mouseenter="hoveredClass = ticketClass.value"
                @mouseleave="hoveredClass = null"
            >
    
                <h2 
                    class="text-lg font-semibold mb-2 transition-colors duration-300" 
                    :class="{
                        'text-green-600': ticketClass.value === 'economy',
                        'text-blue-600': ticketClass.value === 'business',
                        'text-red-600': ticketClass.value === 'first',
                        'scale-110': hoveredClass === ticketClass.value
                    }"
                >
                    {{ ticketClass.label }}
                </h2>
                <p class="text-sm text-gray-500">Giá tiền:</p>
                <p 
                    class="text-2xl font-bold transition-transform duration-300" 
                    :class="{
                        'scale-110': hoveredClass === ticketClass.value
                    }"
                >
                    {{ formatPrice(calculateClassPrice(ticketClass.value)) }}
                </p>
            </div>
        </div>

        <div v-if="localTicket.selectedClass" class="mt-4 bg-pink-50 p-3 rounded-lg transition-all">
            <div class="flex justify-between">
                <div>
                    <p class="text-orange-600 text-xs">Hành lý xách tay</p>
                    <p class="font-medium text-sm">
                        {{ getBaggageInfo(localTicket.selectedClass).carryon }} kg
                    </p>
                </div>
                <div>
                    <p class="text-orange-600 text-xs">Hành lý ký gửi</p>
                    <p class="font-medium text-sm">
                        {{ getBaggageInfo(localTicket.selectedClass).checkedbaggage }} kg
                    </p>
                </div>
            </div>
        </div>
        <div class="text-center">
            <button 
            v-if="localTicket.selectedClass" 
            class="w-1/3 mt-4 px-4 py-2 rounded-lg transition-all duration-300 
            text-white font-semibold
            disabled:bg-gray-400 disabled:cursor-not-allowed
            bg-orange-500 hover:bg-orange-600 hover:shadow-lg 
            focus:outline-none focus:ring-2 focus:ring-orange-500 focus:ring-opacity-50
            active:scale-95"
            @click="selectTicket"
        >
            Chọn chuyến bay
        </button>
        </div>
        
    </div>
</template>
<script>
export default {
    component: {
        
    },
    props: {
        ticket: {
            type: Object,
            required: true
        },
        ticketClasses: {
            type: Array,
            required: true
        }
    },
    data() {
        return {
            localTicket: { ...this.ticket },
            hoveredClass: null
        }
    },
    methods: {
        
        selectTicketClass(classValue) {
            this.localTicket.selectedClass = this.localTicket.selectedClass === classValue ? null : classValue
        },
        selectTicket() {
            //console.log(this.localTicket)
            this.$emit('selected', {
                ...this.localTicket,
                price: this.calculateClassPrice(this.localTicket.selectedClass)
            })
        },
        getBaggageInfo(classType) {
            const ticketClass = this.ticketClasses.find(cls => cls.value === classType)
            return ticketClass ? ticketClass.baggageInfo : { carryon: 0, checkedbaggage: 0 }
        },
        formatPrice(price) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(price)
        },
        calculateClassPrice(classValue) {
            const ticketClass = this.ticketClasses.find(cls => cls.value === classValue)
            return this.ticket.basePrice * (ticketClass?.priceMultiplier || 1)
        }
    },
    computed: {
        calculateFlightDuration() {
            const [departHours, departMins] = this.ticket.departureTime.split(':').map(Number)
            const [arriveHours, arriveMins] = this.ticket.arrivalTime.split(':').map(Number)
            
            let duration = (arriveHours - departHours) * 60 + (arriveMins - departMins)
            if (duration < 0) duration += 24 * 60 // Handle overnight flights
            
            return duration
        }
    }
}
</script>