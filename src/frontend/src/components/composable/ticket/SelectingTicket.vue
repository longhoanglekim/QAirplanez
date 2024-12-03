<template>
<div class="container max-w-sm bg-red-100 text-left grid grid-cols-2">
    <h1 class="col-span-2 text-center">Vé đang chọn</h1>
    <div>Hành trình:</div>
    <div>{{ props.ticket.departureName }}
        <MoveRight /> {{ props.ticket.arrivalName }} </div>
    <div>Số hiệu chuyến bay:</div>
    <div class="border-2">{{ props.ticket.flightNumber }}</div>
    <div>Giờ xuất phát:</div>
    <div>{{ props.ticket.departureTime }} - {{ props.ticket.departureDate }} </div>
    <div>Giờ đến dự kiến:</div>
    <div>{{ props.ticket.arrivalTime }} - {{ props.ticket.arrivalDate }}</div>
    <div>Hạng vé:</div>
    <div>{{ props.ticket.selectedClass }}</div>
    <div>Hành lý mỗi người:</div>
    <div>Xách tay: 5kg</div>
    <div>&nbsp;</div>
    <div>Ký gửi: 10kg</div>
    <div class="col-span-2 text-center">Thành tiền:</div>
    <div class="col-span-2 text-center">{{ calculatePrice() }} VND</div>
</div>
</template>

    
    
<script setup>
import {
    MoveRight
} from 'lucide-vue-next';
import {
    defineProps
} from 'vue';

const props = defineProps({
    ticket: {
        type: Object,
        default: () => ({
            arrivalCode: '',
            arrivalName: '',
            arrivalDate: '',
            arrivalTime: '',
            basePrice: '',
            departureCode: '',
            departureDate: '',
            departureName: '',
            departureTime: '',
            flightNumber: '',
            selectedClass: '',
            adults: 0,
            children: 0
        }),
        validator: (value) => {
            // Optional: Add custom validation
            return Object.keys(value).every(key => {
                switch (key) {
                    case 'adults':
                    case 'children':
                        return typeof value[key] === 'number' && value[key] >= 0;
                    case 'arrivalCode':
                    case 'departureCode':
                        return typeof value[key] === 'string' && value[key].length <= 3;
                    default:
                        return typeof value[key] === 'string';
                }
            });
        }
    }
})

const calculatePrice = () => {
    return props.ticket?.basePrice * (props.ticket?.children + props.ticket?.adults)
}
</script>
    
    
<style scoped>
    </style>
