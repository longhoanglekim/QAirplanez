<template>
<div class="max-w-2xl border-4 rounded-xl border-orange-600 px-3">
    <!--header-->
    <div class="border-b-2 justify-between flex border-red-500 p-2">
        <div>
            <span>{{ props.ticket.departureName }}</span>
            <span> đến </span>
            <span>{{ props.ticket.arrivalName }}</span>
        </div>
        <div>
            <span> Thứ Sáu, 6 tháng 12, 2024</span>
        </div>

    </div>
    <div class="flex justify-between p-2">
        <div class="flex border-r border-red-500 justify-between space-x-4 pr-3">
            <div class="block">
                <div class="font-xl font-bold">8:00</div>
                <div class="font-md">SGN</div>
            </div>
            <move-right class="place-self-center"></move-right>
            <div class="block">
                <div class="font-xl font-bold">8:00</div>
                <div class="font-md ">HAN</div>
            </div>
        </div>
        <div class="text-left pl-3 ">
            <div>Thời gian bay: 135 phút</div>
            <div>Mã số: VN123</div>
        </div>
        <div class="border-l border-red-500 pl-3  ">
            <div>Vé phổ thông</div>
            <div>1.700.000/vé</div>
        </div>
    </div>
</div>
<div>
    <chevron-down class="place-self-center"></chevron-down>
</div>
</template>

    
    
<script setup>
import {
    MoveRight,
    ChevronDown
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
</script>
