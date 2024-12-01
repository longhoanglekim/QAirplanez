<template>
<div class="bg-gradient-to-br from-orange-50 to-red-100 img bg-cover bg-center p-4 mb-2 border-b-4 border-orange-300">
    <div class=" search-result  text-emerald-950 bg-white text-xl font-bold uppercase text-center p-5 shadow-lg rounded-lg w-72 mx-auto m-20">
        Kết quả tìm kiếm
    </div>
</div>
<div class="container p-5 grid xl:grid-cols-3 ">
    <div class="shadow-inner col-span-2  space-y-4">
        <BookedTicket :passengers="passengers"/>
        <BookedTicket />
        <BookedTicket />
        <BookedTicket />
        <BookedTicket />
        <BookedTicket />
    </div>

</div>
</template>

<script setup>
import BookedTicket from '@/components/User/BookedTicket.vue';
import { ref } from 'vue';

const passengers = ref([
            {
                name: 'Ha Van A',
                identifyCode: '00123456789'
            },
            {
                name: 'Tran Van B',
                identifyCode: '00123456789'
            },
            {
                name: 'Ho Van C',
                identifyCode: '00123456789'
            },
            {
                name: 'Nguyen Van A',
                identifyCode: '00123456789'
            }
        ]);
</script>

<style  scoped>

</style>
