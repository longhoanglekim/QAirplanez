<template>
<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-md p-6 relative">
        <!-- Close Button -->
        <button @click="$emit('close')" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
        </button>

        <!-- Modal Title -->
        <h2 class="text-xl font-semibold mb-4 text-center">
            Select Seats
        </h2>

        <!-- Trip Type Selector -->
        <div class="flex justify-center mb-4">
            <div class="flex bg-gray-100 rounded-lg p-1">
                <button @click="currentTrip = 'outbound'" :class="{
                'bg-blue-500 text-white': currentTrip === 'outbound',
                'text-gray-700': currentTrip !== 'outbound'
              }" class="px-4 py-2 rounded-lg transition-colors">
                    Outbound Flight
                </button>
                <button @click="currentTrip = 'return'" :class="{
                'bg-blue-500 text-white': currentTrip === 'return',
                'text-gray-700': currentTrip !== 'return'
              }" class="px-4 py-2 rounded-lg transition-colors" :disabled="!isRoundTrip">
                    Return Flight
                </button>
            </div>
        </div>

        <!-- Seat Grid -->
        <div class="grid grid-cols-10 gap-2 mb-4">
            <button v-for="(seat, seatIndex) in currentTripSeats" :key="seat.id" @click="handleSeatClick(seat)" :disabled="!seat.available" class="w-8 h-8 rounded" :class="{
              'bg-gray-300 cursor-not-allowed': !seat.available,
              'bg-green-500 text-white': currentSelectedSeats.includes(seat.id),
              'bg-blue-500 text-white': seat.available && !currentSelectedSeats.includes(seat.id),
              'hover:bg-blue-600': seat.available
            }">
                {{ seatIndex % 10 + 1 }}
            </button>
        </div>

        <!-- Seat Selection Info -->
        <div class="text-center mb-4">
            <p>
                Selected Seats: {{ currentSelectedSeats.length }} /
                {{ currentTrip === 'outbound' ? outboundTicketCount : returnTicketCount }}
            </p>
        </div>

        <!-- Confirm Button -->
        <button @click="confirmSelection" :disabled="!isSelectionComplete" class="w-full py-2 rounded bg-blue-600 text-white disabled:bg-gray-400 disabled:cursor-not-allowed hover:bg-blue-700 transition-colors">
            {{ currentTrip === 'outbound' ? 'Continue to Return Flight' : 'Confirm Seat Selection' }}
        </button>
    </div>
</div>
</template>

  
  
<script>
export default {
    props: {
        outboundSeats: {
            type: Array,
            required: true
        },
        returnSeats: {
            type: Array,
            default: null
        },
        outboundTicketCount: {
            type: Number,
            required: true
        },
        returnTicketCount: {
            type: Number,
            default: 0
        }
    },
    data() {
        return {
            currentTrip: 'outbound',
            outboundSelectedSeats: [],
            returnSelectedSeats: []
        }
    },
    computed: {
        isRoundTrip() {
            return this.returnSeats !== null;
        },
        currentTripSeats() {
            return this.currentTrip === 'outbound' ?
                this.flattenSeats(this.outboundSeats) :
                this.flattenSeats(this.returnSeats);
        },
        currentSelectedSeats() {
            return this.currentTrip === 'outbound' ?
                this.outboundSelectedSeats :
                this.returnSelectedSeats;
        },
        isSelectionComplete() {
            if (this.currentTrip === 'outbound') {
                return this.outboundSelectedSeats.length === this.outboundTicketCount;
            } else {
                return this.returnSelectedSeats.length === this.returnTicketCount;
            }
        }
    },
    methods: {
        flattenSeats(seats) {
            return seats.flatMap((row, rowIndex) =>
                row.map((isAvailable, seatIndex) => ({
                    id: `${rowIndex}-${seatIndex}`,
                    available: isAvailable,
                    rowIndex,
                    seatIndex
                }))
            )
        },
        handleSeatClick(seat) {
            const currentSelectedSeats = this.currentTrip === 'outbound' ?
                this.outboundSelectedSeats :
                this.returnSelectedSeats;

            const requiredTicketCount = this.currentTrip === 'outbound' ?
                this.outboundTicketCount :
                this.returnTicketCount;

            // Kiểm tra điều kiện chọn ghế
            if (!seat.available || currentSelectedSeats.length >= requiredTicketCount) return;

            // Toggle seat selection
            const seatId = seat.id;
            const currentIndex = currentSelectedSeats.indexOf(seatId);

            if (currentIndex > -1) {
                // Bỏ chọn ghế nếu đã được chọn
                if (this.currentTrip === 'outbound') {
                    this.outboundSelectedSeats.splice(currentIndex, 1);
                } else {
                    this.returnSelectedSeats.splice(currentIndex, 1);
                }
            } else {
                // Chọn ghế mới
                if (this.currentTrip === 'outbound') {
                    this.outboundSelectedSeats.push(seatId);
                } else {
                    this.returnSelectedSeats.push(seatId);
                }
            }
        },
        confirmSelection() {
            if (this.currentTrip === 'outbound') {
                // Chuyển sang chọn ghế chuyến về nếu là vé khứ hồi
                if (this.isRoundTrip) {
                    this.currentTrip = 'return';
                } else {
                    this.$emit('seat-selection', {
                        outbound: this.outboundSelectedSeats,
                        return: []
                    });
                    this.$emit('close');
                }
            } else {
                // Xác nhận chọn ghế chuyến về
                this.$emit('seat-selection', {
                    outbound: this.outboundSelectedSeats,
                    return: this.returnSelectedSeats
                });
                this.$emit('close');
            }
        }
    }
}
</script>
