import { defineStore } from "pinia"
import { ref } from "vue"

export const ticketStore = defineStore('ticketStore', () => {
    const selectedDeparture = ref({
        arrivalCode: '',
        arrivalName:'',
        arrivalDate: '',
        arrivalTime: '',
        basePrice: '',
        departureCode: '',
        departureName: '',
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
        arrivalName:'',
        arrivalDate: '',
        arrivalTime: '',
        basePrice: '',
        departureCode: '',
        departureName: '',
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

    const getSelectedArrival = () => {
        return selectedArrival.value
    }
    const getSelectedDeparture = () => {
        return selectedArrival.value
    }

    return {saveDepartureTicket, saveArrivalTicket, getSelectedArrival, getSelectedDeparture}
})