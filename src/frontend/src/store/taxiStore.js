import { defineStore } from "pinia";
import { ref } from "vue";

export const  useTaxiStore =  defineStore('taxiStore', () => {
  const transferServices =  ref([
        {
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
    ])
    const getTransferServicesById = (id) => {
        return transferServices.value.find(service => service.id === id)
    }
    return {
        transferServices,
        getTransferServicesById
    }
})