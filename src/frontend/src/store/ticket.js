import { defineStore } from "pinia"
import { ref } from "vue"

export const ticketStore = defineStore('ticketStore', () => {
    const selected = ref({
        arrivalCode: '',
        arrivalDate: '',
        arrivalTime: '',
        basePrice: '',
        departureCode: '',
        departureDate: '',
        departureTime: '',
        flightNumber: '',
        selectedClass: '',
    })

    const saveTicket = (selectedTicket) => {
        selected.value = {...selectedTicket}
    } 


    return {selected, saveTicket}
})