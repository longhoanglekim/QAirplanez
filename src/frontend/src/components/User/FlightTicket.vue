<template>
    <div class="max-w-4xl transform transition duration-300 hover:scale-105">
        <div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-red-500/50">
            <!-- Header -->
            <div class="p-4 bg-red-600 text-white flex justify-between items-center">
                <div class="flex items-center">
                    <span class="text-xl font-bold mr-2">{{ ticket.departureCode }}</span>
                    <MoveRight class=""/>
                    <span class="text-xl font-bold ml-2">{{ ticket.arrivalCode }}</span>
                </div>
                <div class="text-sm">{{ ticket.flightNumber }}</div>
            </div>

            <div class="p-4">
                <!-- Flight Time -->
                <div class="flex justify-between mb-4">
                    <div>
                        <p class="text-orange-600 text-sm">Khởi hành</p>
                        <p class="font-semibold">{{ ticket.departureTime }}</p>
                        <p class="text-xs text-gray-500">{{ ticket.departureDate }}</p>
                    </div>
                    <MoveRight class="text-red-600"/>
                    <div class="text-right">
                        <p class="text-orange-600 text-sm">Đến nơi</p>
                        <p class="font-semibold">{{ ticket.arrivalTime }}</p>
                        <p class="text-xs text-gray-500">{{ ticket.arrivalDate }}</p>
                    </div>
                </div>

                <!-- Ticket Class Selection -->
                <div class="mb-4">
                    <p class="text-orange-600 text-sm mb-2">Chọn hạng vé</p>
                    <div class="flex space-x-2">
                        <button v-for="(ticketClass, index) in ticketClasses" :key="index" 
                            @click="selectTicketClass(ticketClass.value)" 
                            :class="[
                                'px-3 py-1 rounded-full text-sm transition-colors duration-200 border',
                                localTicket.selectedClass === ticketClass.value 
                                    ? 'bg-orange-500 text-white border-orange-500' 
                                    : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-100'
                            ]">
                            {{ ticketClass.label }}
                        </button>
                    </div>
                </div>

                <!-- Baggage Information -->
                <div v-if="localTicket.selectedClass" class="bg-pink-50 p-3 rounded-lg mb-4">
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

                <!-- Price and Flight Duration -->
                <div class="bg-pink-50 p-3 rounded-lg mb-4">
                    <div class="flex justify-between items-center">
                        <div>
                            <p class="text-orange-600 text-xs">Giá</p>
                            <p class="font-bold text-lg text-red-600">
                                {{ calculateTicketPrice }}
                            </p>
                        </div>
                        <div class="text-right">
                            <p class="text-orange-600 text-xs">Thời gian bay</p>
                            <p class="font-medium text-sm text-rose-700">
                                {{ calculateFlightDuration }} phút
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="flex space-x-2">
                    <button 
                        :disabled="!localTicket.selectedClass" 
                        class="flex-1 px-4 py-2 rounded-lg transition-colors 
                        text-white font-semibold
                        disabled:bg-gray-400 
                        bg-orange-500 hover:bg-orange-600"
                    >
                        Chọn chuyến
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { MoveRight } from 'lucide-vue-next'

export default {
    components: {
        MoveRight
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
            localTicket: { ...this.ticket }
        }
    },
    methods: {
        selectTicketClass(classValue) {
            this.localTicket.selectedClass = this.localTicket.selectedClass === classValue ? null : classValue
            this.$emit('update:ticket', { ...this.localTicket })
        },
        getBaggageInfo(classType) {
            const ticketClass = this.ticketClasses.find(cls => cls.value === classType)
            return ticketClass ? ticketClass.baggageInfo : null
        },
        formatPrice(price) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
            }).format(price)
        },
        convertTimeToMinutes(timeString) {
            const [hours, minutes] = timeString.split(':').map(Number)
            return hours * 60 + minutes
        }
    },
    computed: {
        calculateTicketPrice() {
            if (!this.localTicket.selectedClass) return this.formatPrice(this.localTicket.basePrice)

            const ticketClass = this.ticketClasses.find(cls => cls.value === this.localTicket.selectedClass)
            const price = this.localTicket.basePrice * ticketClass.priceMultiplier

            return this.formatPrice(price)
        },
        calculateFlightDuration() {
            const departureMinutes = this.convertTimeToMinutes(this.localTicket.departureTime)
            const arrivalMinutes = this.convertTimeToMinutes(this.localTicket.arrivalTime)
            return arrivalMinutes - departureMinutes
        }
    }
}
</script>