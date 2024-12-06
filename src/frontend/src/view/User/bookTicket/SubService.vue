<template>
<SeatSelectionModal v-if="currentModal === 'seat-selection'" :outbound-seats="outboundSeats" :return-seats="returnSeats" :outbound-ticket-count="2" :return-ticket-count="2" @close="closeModal" @seat-selection="handleSeatSelection" />
<MealSelectionModal v-if="currentModal === 'meal-selection'" :isRoundTrip="isRoundTrip" @close="closeModal" />
<TaxiModal v-if="currentModal === 'taxi-selection'" @close="closeModal" />
<div>
    <header class="mt-20">
        <BookingProgressBar class="mx-auto" :current-stage="2" />
    </header>
    <main class="flex flex-col text-left bg-slate-100 mx-4 lg:mx-32 rounded-xl ">
        <CardWithButton @beClicked="currentModal = 'seat-selection'">
            <template v-slot:header>
                Chọn chỗ ngồi
            </template>
            <template v-slot:slogan>

            </template>
            <template v-slot:content>
                
            </template>
        </CardWithButton>
        <CardWithButton @beClicked="currentModal = 'meal-selection'">
            <template v-slot:header>
                Chọn bữa ăn
            </template>
            <template v-slot:slogan>

            </template>
            <template v-slot:content>
                
            </template>
        </CardWithButton>
        <CardWithButton @beClicked="currentModal = 'taxi-selection'">
            <template v-slot:header>
                Chọn dịch vụ đưa đón
            </template>
            <template v-slot:slogan>

            </template>
            <template v-slot:content>
                
            </template>
        </CardWithButton>
    </main>
</div>
</template>

  
  
<script>
import SeatSelectionModal from '@/components/composable/service/SeatSelectionModal.vue';
import MealSelectionModal from '@/components/composable/service/MealSelectionModal.vue';
import TaxiModal from '@/components/composable/service/TaxiModal.vue';
import BookingProgressBar from '@/components/composable/BookingProgressBar.vue';
import CardWithButton from '@/components/composable/card/CardWithButton.vue';

export default {
    data() {
        return {
            currentModal: '',
            outboundSeats: [
                [true, true, false, true, true, false],
                [true, false, false, true, true, false]
            ],
            returnSeats: [
                [true, true, true, true, false, true],
                [false, true, true, true, true, true]
            ]
        }
    },
    components: {
        SeatSelectionModal,
        MealSelectionModal,
        TaxiModal,
        BookingProgressBar,
        CardWithButton
    },
    methods: {
        handleSeatSelection({
            outbound,
            return: returnSeats
        }) {
            // Xử lý các ghế đã chọn cho cả chuyến đi và chuyến về
            console.log('Outbound seats:', outbound);
            console.log('Return seats:', returnSeats);
        },
        closeModal() {
            this.currentModal = ''
        }
    }
}
</script>
