<template>
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg w-10/12 lg:w-6/12  shadow-xl relative max-h-sm">
        <div class="flex justify-between items-center p-6 border-b border-yellow-500">
            <h2 class="text-2xl font-bold flex items-center text-orange-600">
                <Car class="h-8 w-8 mr-5" />
                Chọn dịch vụ đưa đón
            </h2>
            <button @click="$emit('close')" class="text-gray-500 hover:text-orange-600 transition-colors">
                <X class="h-8 w-8 hover:rotate-90 transition-all duration-300 hover:scale-125" />
            </button>
        </div>

        <div class="space-y-3 max-h-[30rem] overflow-y-auto">
            <div v-for="service in transferServices" :key="service.id" :class="[
                'flex items-center p-3 mx-10 border rounded-lg cursor-pointer first:mt-5',
                'transition transform hover:scale-105',
                containService(service) 
                  ? 'bg-amber-50 border-amber-400' 
                  : 'bg-white border-gray-400'
              ]" @click="toggleService(service)">
                <div class="flex-grow">
                    <div class="font-semibold">{{ service.name }}</div>
                    <div class="text-sm text-gray-500">
                        {{ service.description }}
                    </div>
                    <div class="text-sm text-gray-500">
                        {{ service.price }} VNĐ
                    </div>
                </div>
                <CheckCircle2Icon v-if="containService(service)" :size="24" class="text-orange-500 ml-2" />
            </div>
        </div>

        <div class="  p-6 border-t flex justify-between items-center bg-amber-50 rounded-b-lg">
            <div class="text-center mb-4 text-orange-700">
                <p class="font-semibold text-orange-600">
                    Tổng chi phí:
                    <span class="text-yellow-600 ml-2">
                        {{ formatCurrency(selectedServices.reduce((total, service) => total + service.price, 0)) }}
                    </span>
                </p>
            </div>
            <div class="space-x-4">
                <button @click="closeModal" class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">
                    Hủy
                </button>
                <button @click="confirmServices" class="px-4 py-2 bg-amber-400 text-white rounded hover:bg-amber-500">
                    Xác nhận
                </button>
            </div>
        </div>
    </div>
</div>
</template>

<script>
import {
    X,
    CheckCircle2Icon,
    Car
} from 'lucide-vue-next'

export default {
    components: {
        X,
        CheckCircle2Icon,
        Car
    },
    props: {
        services: {
            type: Array,
            default: () => []
        }
    },
    data() {
        return {
            selectedServices: [...this.$props.services],
            transferServices: [{
                    id: 'home-pickup',
                    name: 'Đón tại nhà',
                    description: 'Đón khách tại địa chỉ nhà',
                    price: 55000
                },
                {
                    id: 'airport-pickup',
                    name: 'Đón tại sân bay',
                    description: 'Đón khách ngay tại sân bay',
                    price: 200000
                },
                {
                    id: 'vip-service',
                    name: 'Dịch vụ VIP',
                    description: 'Trải nghiệm dịch vụ cao cấp',
                    price: 1000000
                },
                {
                    id: 'child-support',
                    name: 'Hỗ trợ trẻ em',
                    description: 'Hỗ trợ đặc biệt cho trẻ em',
                    price: 100000
                },
                {
                    id: 'wheelchair',
                    name: 'Hỗ trợ xe lăn',
                    description: 'Hỗ trợ hành khách khuyết tật',
                    price: 300000
                },
                {
                    id: 'luggage-help',
                    name: 'Hỗ trợ hành lý',
                    description: 'Hỗ trợ mang và xử lý hành lý',
                    price: 200000
                }
            ]
        }
    },
    computed: {

    },
    methods: {
        closeModal() {
            console.log('selectedTaxi', this.$props.services)
            this.$emit('close')
        },
        toggleService(service) {
            if (this.containService(service)) {
                this.selectedServices = this.selectedServices.filter(selected => selected.id !== service.id)
            } else {
                this.selectedServices.push(service)
            }
        },
        confirmServices() {
            this.$emit('taxi-selection', this.selectedServices)
            this.$emit('close')
        },
        containService(service) {
            return this.selectedServices.findIndex(selected => selected.id === service.id) !== -1
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
