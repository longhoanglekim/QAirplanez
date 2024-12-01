<template>
<div class="bg-white shadow-lg rounded-lg overflow-hidden hover:shadow-red-500/50">
    <!-- Header -->
    <div class="p-4 bg-red-600 text-white flex justify-between items-center">
        <div class="flex items-center">
            <span class="text-xl font-bold mr-2">{{ ticket.departureCode }}</span>
            <MoveRight class="" />
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
            <MoveRight class="text-red-600" />
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
                <button v-for="(ticketClass, index) in ticketClasses" :key="index" @click="ticket.selectedClass = (ticket.selectedClass === ticketClass.value ? null: ticketClass.value)" :class="[
                    'px-3 py-1 rounded-full text-sm transition-colors duration-200 border',
                    ticket.selectedClass === ticketClass.value 
                        ? 'bg-orange-500 text-white border-orange-500' 
                        : 'bg-white text-gray-700 border-gray-300 hover:bg-gray-100'
                ]">
                    {{ ticketClass.label }}
                </button>
            </div>
        </div>

        <!-- Baggage Information -->
        <div v-if="ticket.selectedClass" class="bg-pink-50 p-3 rounded-lg mb-4">
            <div class="flex justify-between">
                <div>
                    <p class="text-orange-600 text-xs">Hành lý xách tay</p>
                    <p class="font-medium text-sm">
                        {{ getBaggageInfo(ticket.selectedClass).carryon }} kg
                    </p>
                </div>
                <div>
                    <p class="text-orange-600 text-xs">Hành lý ký gửi</p>
                    <p class="font-medium text-sm">
                        {{ getBaggageInfo(ticket.selectedClass).checkedbaggage }} kg
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
                        {{ calculateTicketPrice(ticket) }}
                    </p>
                </div>
                <div class="text-right">
                    <p class="text-orange-600 text-xs">Thời gian bay</p>
                    <p class="font-medium text-sm text-rose-700">
                        {{ calculateFlightDuration(ticket) }} phút
                    </p>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex space-x-2">
            <button :disabled="!ticket.selectedClass" class="flex-1 px-4 py-2 rounded-lg transition-colors 
                text-white font-semibold
                disabled:bg-gray-400 
                bg-orange-500 hover:bg-orange-600">
                Chọn chuyến
            </button>
        </div>
    </div>
</div>
</template>

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
        ticketType: {
            type: String,
            default: 'Người Lớn'
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
        airline: {
            type: String,
            default: 'Vietnam Airlines'
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
            default: '0,000,000'
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
</style>
