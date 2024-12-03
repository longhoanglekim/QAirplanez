<template>
    <div class="container justify-center bg-orange-50">
        <header class="flex items-center justify-center mb-10 pt-20">
            <BookingProgressBar :current-stage="2" />
        </header>
        <main class="space-y-4">

            <div class="custom w-full max-w-4xl place-self-center rounded-lg bg-white m-8" v-for="i in adults" :key="i">
                <h1 class="text-left p-5 font-bold">Người lớn {{ i }}</h1>
                <adult-passenger-form></adult-passenger-form>
            </div>
            <div class="custom w-full max-w-4xl place-self-center rounded-lg bg-white m-8" v-for="i in children" :key="i">
                <h1 class="text-left p-5 font-bold">Trẻ em {{ i }}</h1>
                <child-passenger-form></child-passenger-form>
            </div>
            <div class="my-20">
                <button class="p-5 rounded-xl bg-orange-500 hover:scale-105 custom">Xác nhận thông tin</button>
            </div>
        </main>
        <footer class="my-10"></footer>
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
.custom {
    box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.3), 0px 4px 6px rgba(0, 0, 0, 0.3);
}

</style>