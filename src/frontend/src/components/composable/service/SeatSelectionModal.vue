<template>
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-xl max-h-[90vh] overflow-y-auto
               ">
        <div class="flex justify-between items-center p-6 border-b border-yellow-500">
            <h2 class="text-2xl font-bold flex items-center text-orange-600">
                <Armchair class="h-8 w-8 mr-5"/> Chọn chỗ ngồi
            </h2>
        <button @click="$emit('close')" class="text-gray-500 hover:text-orange-600 transition-colors">
          <X class="h-8 w-8 hover:rotate-90 transition-all duration-300 hover:scale-125"/>
        </button>
      </div>

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
        <div class="grid grid-cols-6 gap-2 mb-4 overflow-y-auto max-h-32 
                    px-4
                    shadow-inner
                    text-center
                    bg-gray-100
                    md:max-h-64
                    ">
            <div class="bg-red-100 text-orange-700 rounded-b-md py-1 col-span-6 sticky top-0  z-20">Hạng nhất</div>
            <div v-for="seat in firstSeats" :key="seat.id" @click="handleSeatClick(seat)" :disabled="!seat.available" 
            class="rounded border-2 border-orange-500"
            :class="{'bg-gray-300 cursor-not-allowed': !seat.available,
            'bg-orange-500 text-white': this.currentSelectedSeats.includes(seat.id),
            'bg-white text-orange-500': seat.available && !this.currentSelectedSeats.includes(seat.id),
            'hover:bg-orange-600 hover:text-white': seat.available && !this.currentSelectedSeats.includes(seat.id)}">
            {{ seat.id }}
            </div>

            <div class="bg-red-100 text-orange-700 rounded-b-md py-1 col-span-6 sticky top-0  z-20">Hạng thương gia</div>
            <div v-for="seat in businessSeats" :key="seat.id" @click="handleSeatClick(seat)" :disabled="!seat.available" 
            class="rounded border-2 border-orange-500"
            :class="{'bg-gray-300 cursor-not-allowed': !seat.available,
            'bg-orange-500 !text-white': this.currentSelectedSeats.includes(seat.id),
            'bg-white text-orange-500': seat.available && !this.currentSelectedSeats.includes(seat.id),
            'hover:bg-orange-600 hover:text-white': seat.available && !this.currentSelectedSeats.includes(seat.id)}">
            {{ seat.id }}
            </div>

            <div class="bg-red-100 text-orange-700 rounded-b-md py-1 col-span-6 sticky top-0  z-20">Hạng thường</div>
            <div v-for="seat in economySeats" :key="seat.id" @click="handleSeatClick(seat)" :disabled="!seat.available" 
            class="rounded border-2 border-orange-500"
            :class="{'bg-gray-300 cursor-not-allowed': !seat.available,
            'bg-orange-500 text-white': this.currentSelectedSeats.includes(seat.id),
            'bg-white text-orange-500': seat.available && !this.currentSelectedSeats.includes(seat.id),
            'hover:bg-orange-600 hover:text-white': seat.available && !this.currentSelectedSeats.includes(seat.id)}">
            {{ seat.id }}
            </div>
        </div>

        <!-- Seat Selection Info -->
        
    
        <!-- Confirm Button -->
         <div class="p-6 border-t flex justify-between items-center bg-amber-50">
            <div class="text-center mb-4 text-orange-700">
                <p class="font-semibold text-orange-600">
                    Tổng chi phí:
                    <span class="text-yellow-600 ml-2">
                    {{ formatCurrency((outboundSelectedSeats.length+ (returnSelectedSeats  ? returnSelectedSeats.length : 0)) * priceSeat) }}
                    </span>
                </p>
                <p class="text-sm text-gray-600">
                    Đã chọn: {{ currentSelectedSeats.length }} /
                    {{ currentTrip === 'outbound' ? outboundTicketCount : returnTicketCount }} ghế
                </p>
            </div>
            <div class="space-x-4">
                <button class="px-4 py-2 bg-gray-100 text-gray-800 rounded border border-gray-300 hover:bg-gray-200" @click="$emit('close')">
                    Hủy
                </button>
                <button @click="confirmSelection"
                class="px-4 py-2 bg-orange-500 text-white rounded hover:bg-orange-700 disabled:opacity-50 cursor-pointer" 
                >
                {{ isRoundTrip ? (currentTrip === 'outbound' ? 'Chọn chỗ chuyến về' : 'Hoàn tất') : 'Hoàn tất' }}
                </button>
            </div>
        </div>
    </div>
</div>
</template>

  
  
<script>
import { X, Armchair } from 'lucide-vue-next';

import { ticketStore } from '@/store/ticket';

export default {
    components: {
        X,
        Armchair
    },
    props: {
        priceSeat: {
            type: Number,
            default: 55000
        },
        outboundSeats: {
            type: Array,
            required: true
        },
        returnSeats: {
            type: Array,
            default: null
        },
        selectedOutboundSeats: {
            type: Array,
            default: () => []
        },
        selectedReturnSeats: {
            type: Array,
            default: () => []
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
            outboundSelectedSeats: [...this.selectedOutboundSeats],
            returnSelectedSeats: [...this.selectedReturnSeats]
        }
    },
    computed: {
        isRoundTrip() {
            return this.returnSeats !== null && this.returnSeats.length > 0;
        },
        currentTripSeats() {
            return this.currentTrip === 'outbound' ?
                this.flattenSeats(this.outboundSeats) :
                this.flattenSeats(this.returnSeats);
        },
        firstSeats() {
            const storeTicket = ticketStore()
            if (this.currentTrip === 'outbound' && storeTicket.getSelectedDeparture().selectedClass !== 'first') {
                return []
            }
            if (this.currentTrip === 'return' && storeTicket.getSelectedArrival().selectedClass !== 'first') {
                return []
            }
            const totalSeats = this.currentTripSeats.length;
            const maxFirst = Math.floor(totalSeats * 0.1);
            const firstClassSeats = Math.floor(maxFirst / 6) * 6;
            return this.currentTripSeats.slice(0, firstClassSeats);
        },

         businessSeats() {
            const storeTicket = ticketStore()
            if (this.currentTrip === 'outbound' && storeTicket.getSelectedDeparture().selectedClass !== 'business') {
                return []
            }
            if (this.currentTrip === 'return' && storeTicket.getSelectedArrival().selectedClass !== 'business') {
                return []
            }
            const totalSeats = this.currentTripSeats.length;
            const firstClassSeats = Math.floor(Math.floor(totalSeats * 0.1) / 6) * 6;
            // Số ghế thương gia (20% và chia hết cho 6)
            const maxBusiness = Math.floor(totalSeats * 0.2);
            const businessClassSeats = Math.floor(maxBusiness / 6) * 6;
            return this.currentTripSeats.slice(
                firstClassSeats, 
                firstClassSeats + businessClassSeats
        );
    },

    economySeats() {
        const storeTicket = ticketStore()
        if (this.currentTrip === 'outbound' && storeTicket.getSelectedDeparture().selectedClass !== 'economy') {
            return []
        }
        if (this.currentTrip === 'return' && storeTicket.getSelectedArrival().selectedClass !== 'economy') {
            return []
        }
        const totalSeats = this.currentTripSeats.length;
        const firstClassSeats = Math.floor(Math.floor(totalSeats * 0.1) / 6) * 6;
        const businessClassSeats = Math.floor(Math.floor(totalSeats * 0.2) / 6) * 6;
        return this.currentTripSeats.slice(
        firstClassSeats + businessClassSeats
            );
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
                console.log('returnSelectedSeats', this.returnSelectedSeats)
                // Xác nhận chọn ghế chuyến về
                this.$emit('seat-selection', {
                    outbound: this.outboundSelectedSeats,
                    returned: this.returnSelectedSeats
                });
                this.$emit('close');
            }
        },
        
        formatCurrency(value) {
            return new Intl.NumberFormat('vi-VN', {
                style: 'currency',
                currency: 'VND'
        }).format(value );
        }

    }
}
</script>
