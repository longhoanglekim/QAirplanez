<template>
    <div class="container mt-20 justify-center">
        <header class="flex items-center justify-center">
            <BookingProgressBar :current-stage="2" />
        </header>
        <main class="flex flex-col items-center justify-center">
            <div v-for="i in adults" :key="i">
                <adult-passenger-form></adult-passenger-form>
            </div>
            <div v-for="i in children" :key="i">
                <child-passenger-form></child-passenger-form>
            </div>
        </main>
    </div>
    
</template>

<script setup>
import BookingProgressBar from '@/components/composable/BookingProgressBar.vue';
import AdultPassengerForm from '@/components/composable/form/AdultPassengerForm.vue';
import ChildPassengerForm from '@/components/composable/form/ChildPassengerForm.vue';
import { searchFlightStore } from '@/store/searchFlight';
import { ref } from 'vue';

const store = searchFlightStore()

const submittedForm = ref(store.getOldForm())

const adults = submittedForm.value.adults
const children = submittedForm.value.children

</script>


<style scoped>


</style>