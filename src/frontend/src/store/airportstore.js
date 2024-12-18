import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAirportStore = defineStore('airport', () => {
    const airports = ref([])
    const reloadAirports = async () => {
        try {
            const response = await fetch('http://localhost:8080/api/airport/public/airportList', {
                method : 'Get',
                headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
            }
            });
            if (response.ok) {
                const data = await response.json()
                airports.value = data
                return { success: true }
            } else {
                return { success: false }
            }
        } catch (error) {
            console.error('Error fetching airports:', error)
            return { success: false }
        }
    }
    const getAirports = () => { 
        return airports.value
    }
    return { reloadAirports, getAirports }
})