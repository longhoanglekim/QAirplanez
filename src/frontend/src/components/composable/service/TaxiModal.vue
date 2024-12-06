<template>
    <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg w-96 p-6 shadow-xl relative">
            <button @click="closeModal" class="absolute top-4 right-4 text-gray-500 hover:text-gray-700">
                <XIcon :size="24" />
            </button>

            <h2 class="text-2xl font-bold mb-4 text-center">
                Dịch vụ đưa đón
            </h2>

            <div class="space-y-3">
                <div v-for="service in transferServices" :key="service.id" :class="[
                'flex items-center p-3 border rounded-lg cursor-pointer',
                'transition transform hover:scale-105',
                selectedServices.includes(service.id) 
                  ? 'bg-blue-50 border-blue-500' 
                  : 'bg-white border-gray-200'
              ]" @click="toggleService(service.id)">
                    <div class="flex-grow">
                        <div class="font-semibold">{{ service.name }}</div>
                        <div class="text-sm text-gray-500">
                            {{ service.description }}
                        </div>
                    </div>
                    <CheckCircle2Icon v-if="selectedServices.includes(service.id)" :size="24" class="text-blue-500 ml-2" />
                </div>
            </div>

            <div class="mt-6 flex justify-between">
                <button @click="closeModal" class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">
                    Hủy
                </button>
                <button @click="confirmServices" class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
                    Xác nhận
                </button>
            </div>
        </div>
    </div>
</template>

  
  
<script>
import { XIcon, CheckCircle2Icon } from 'lucide-vue-next'

export default {
  components: {
    XIcon,
    CheckCircle2Icon
  },
  data() {
    return {
      selectedServices: [],
      transferServices: [
        {
          id: 'home-pickup',
          name: 'Đón tại nhà',
          description: 'Đón khách tại địa chỉ nhà'
        },
        {
          id: 'airport-pickup',
          name: 'Đón tại sân bay',
          description: 'Đón khách ngay tại sân bay'
        },
        {
          id: 'vip-service',
          name: 'Dịch vụ VIP',
          description: 'Trải nghiệm dịch vụ cao cấp'
        },
        {
          id: 'child-support',
          name: 'Hỗ trợ trẻ em',
          description: 'Hỗ trợ đặc biệt cho trẻ em'
        },
        {
          id: 'wheelchair',
          name: 'Hỗ trợ xe lăn',
          description: 'Hỗ trợ hành khách khuyết tật'
        },
        {
          id: 'luggage-help',
          name: 'Hỗ trợ hành lý',
          description: 'Hỗ trợ mang và xử lý hành lý'
        }
      ]
    }
  },
  methods: {
    closeModal() {
      this.$emit('close')
    },
    toggleService(serviceId) {
      if (this.selectedServices.includes(serviceId)) {
        this.selectedServices = this.selectedServices.filter(id => id !== serviceId)
      } else {
        this.selectedServices.push(serviceId)
      }
    },
    confirmServices() {
      console.log('Selected services:', this.selectedServices)
      this.$emit('taxi-selection', this.selectedServices)
      this.$emit('close')
    }
  }
}
</script>

