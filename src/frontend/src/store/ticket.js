import { defineStore } from "pinia"
import { ref } from "vue"

export const ticketStore = defineStore('ticketStore', () => {
    const selectedDeparture = ref({
        arrivalCode: '',
        arrivalDate: '',
        arrivalTime: '',
        basePrice: '',
        departureCode: '',
        departureDate: '',
        departureTime: '',
        flightNumber: '',
        selectedClass: '',
        adults: 0,
        children: 0
    })

    const saveDepartureTicket = (selectedTicket) => {
        selectedDeparture.value = {...selectedTicket}
    } 

    const selectedArrival = ref({
        arrivalCode: '',
        arrivalDate: '',
        arrivalTime: '',
        basePrice: '',
        departureCode: '',
        departureDate: '',
        departureTime: '',
        flightNumber: '',
        selectedClass: '',
        adults: 0,
        children: 0
    })

    const saveArrivalTicket = (selectedTicket) => {
        selectedArrival.value = {...selectedTicket}
    }

    return {saveDepartureTicket, saveArrivalTicket, selectedArrival, selectedDeparture}
})