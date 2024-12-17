<template>
<div class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
    <div class="bg-white rounded-lg shadow-xl w-full p-6 relative max-w-xs sm:max-w-sm md:max-w-md lg:max-w-lg xl:max-w-xl
               ">
        <!-- Close Button -->
        <button @click="$emit('close')" 
        class="absolute top-4 right-4 text-orange-500 hover:text-orange-700">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
        </button>

        <!-- Modal Title -->
        <h2 class="text-xl font-semibold mb-4 text-center text-orange-700">
            Chọn ghế
        </h2>

        <!-- Trip Type Selector -->
        <div class="flex justify-center mb-4">
            <div class="flex bg-orange-50 rounded-lg p-1">
                <button @click="currentTrip = 'outbound'" :class="{
                'bg-orange-500 text-white hover:bg-orange-600': currentTrip === 'outbound',
                'text-orange-700 hover:bg-orange-100': currentTrip !== 'outbound'
              }" class="px-4 py-2 rounded-lg transition-colors">
                    Chuyến đi
                </button>
                <button @click="currentTrip = 'return'" 
                v-if="isRoundTrip"
                :class="{
                'bg-orange-500 text-white hover:bg-orange-600': currentTrip === 'return',
                'text-orange-700 hover:bg-orange-100': currentTrip !== 'return'
              }" class="px-4 py-2 rounded-lg transition-colors" :disabled="!isRoundTrip">
                    Chuyến về
                </button>
            </div>
        </div>
      <div class="grid grid-cols-6 gap-2 overflow-y-auto max-h-8
                    bg-orange-50 rounded-lg shadow-md py-1
                    [&>*:not(:last-child)]:border-r [&>*]:border-orange-200
                    ">
        <div class="text-center text-orange-600 font-medium">A</div>
        <div class="text-center text-orange-600 font-medium" >B</div>
        <div class="text-center text-orange-600 font-medium">C</div>
        <div class="text-center text-orange-600 font-medium">D</div>
        <div class="text-center text-orange-600 font-medium">E</div>
        <div class="text-center text-orange-600 font-medium">F</div>
      </div>
      
        <!-- Seat Grid -->
        <div class="grid grid-cols-6 gap-2 mb-4 overflow-y-auto max-h-32 relative
                    shadow-inner
                    
                    bg-gray-100
                    md:max-h-64
                    ">
            <div v-for="seat in currentTripSeats" :key="seat"
            class="col-span-6 sticky top-0 left-0 z-20">
                <div v-if="seat === 0" 
                class="bg-red-100 text-orange-700 rounded-b-md py-1 px-2 mx-auto">
                Hạng nhất
                </div>
                <div v-else-if="seat === Math.floor(currentTripSeats.length * 0.1 - 6)" 
                class="bg-red-100 text-orange-700 rounded-b-md py-1 px-2 mx-auto">
                Hạng thương gia
                </div>
                <div v-else-if="seat === Math.floor(currentTripSeats.length * 0.3 - 6)" 
                class="bg-red-100 text-orange-700 rounded-b-md py-1 px-2 mx-auto">
                Hạng phổ thông
                </div>
            </div>
            <div v-for="(seat, seatIndex) in currentTripSeats" :key="seatIndex" 
            @click="handleSeatClick(seat)" 
            :disabled="!seat.available" 
            :class="{
                'w-8 h-8 rounded mx-auto py-auto': true,
                'bg-gray-400 cursor-not-allowed': !seat.available,
                'bg-orange-400 text-white border-2 border-orange-500': this.currentSelectedSeats.includes(seat.id),
                'bg-white border-2 border-orange-500 text-orange-700 hover:bg-orange-600 hover:text-white': seat.available && !this.currentSelectedSeats.includes(seat.id),
                'mb-10': seatIndex === this.currentTripSeats.length * 0.1 - 6 || 
                         seatIndex === this.currentTripSeats.length * 0.3 - 6
            }">
                <div class="mb-4 ">
                {{ Math.floor(seatIndex / 6) + 1 }}
                </div>
            </div>
        </div>

        <!-- Seat Selection Info -->
        <div class="text-center mb-4 text-orange-700">
            <p>
                Selected Seats: {{ currentSelectedSeats.length }} /
                {{ currentTrip === 'outbound' ? outboundTicketCount : returnTicketCount }}
            </p>
        </div>

        <!-- Confirm Button -->
        <button @click="confirmSelection"
        class="w-full py-2 rounded bg-orange-500 text-white disabled:bg-gray-400 
        xl:w-1/2 mx-auto
        disabled:cursor-not-allowed hover:bg-orange-600 transition-colors">
            {{ isRoundTrip ? (currentTrip === 'outbound' ? 'Chọn chỗ chuyến về' : 'Hoàn tất') : 'Hoàn tất' }}
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
        }
    },
    methods: {
        flattenSeats(seats) {
            return seats.flatMap((row, rowIndex) => {
              const col = ['A', 'B', 'C', 'D', 'E', 'F'];
              return row.map((isAvailable, seatIndex) => ({
                  id: `${col[seatIndex]}-${rowIndex + 1}`,
                  available: isAvailable,
                  rowIndex,
                  seatIndex
                }))
            }
            )
        },

        handleSeatClick(seat) {
            console.log("Seat:" + seat);
            console.log("currenTripSeats: ", this.currentTripSeats.length)
            const currentSelectedSeats = this.currentTrip === 'outbound' ?
                this.outboundSelectedSeats :
                this.returnSelectedSeats;

            const requiredTicketCount = this.currentTrip === 'outbound' ?
                this.outboundTicketCount :
                this.returnTicketCount;

            // Kiểm tra điều kiện chọn ghế
            if (!seat.available) return;
            // Toggle seat selection
            const seatId = seat.id;
            const currentIndex = currentSelectedSeats.indexOf(seatId);
            if (currentSelectedSeats.length >= requiredTicketCount) {
                if (this.currentTrip === 'outbound') {
                    this.outboundSelectedSeats.shift();
                } else {
                    this.returnSelectedSeats.shift();
                }
            }
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
        },
        getMaxBusinessRow(rows) {
          return rows * 0.1 + rows * 0.2;
        },
        // getSeatClasses(seat, seatIndex) {
        //   const isHeaderRow = seatIndex === 0 || 
        //                      seatIndex === Math.floor(this.currentTripSeats.length * 0.1 - 6) || 
        //                      seatIndex === Math.floor(this.currentTripSeats.length * 0.3 - 6);

        //   if (isHeaderRow) {
        //     return {
        //       'col-span-6 sticky top-0 left-0 z-20': true
        //     };
        //   }

        //   return {
        //     'w-8 h-8 rounded mx-auto py-auto': true,
        //     'bg-gray-400 cursor-not-allowed': !seat.available,
        //     'bg-orange-400 text-white border-2 border-orange-500': this.currentSelectedSeats.includes(seat.id),
        //     'bg-white border-2 border-orange-500 text-orange-700 hover:bg-orange-600 hover:text-white': seat.available && !this.currentSelectedSeats.includes(seat.id),
        //     'mb-10': seatIndex === this.currentTripSeats.length * 0.1 - 6 || 
        //              seatIndex === this.currentTripSeats.length * 0.3 - 6
        //   };
        // }

    }
}
</script>
