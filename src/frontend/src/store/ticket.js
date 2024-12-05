import { ref } from 'vue'
import { defineStore } from 'pinia'

export const ticketStore = defineStore('ticketStore', () => {
    // Function to save ticket to sessionStorage
    const saveTicketToStorage = (key, ticket) => {
        try {
            sessionStorage.setItem(key, JSON.stringify(ticket))
        } catch (error) {
            console.error('Error saving ticket to sessionStorage:', error)
        }
    }

    // Function to get ticket from sessionStorage
    const getTicketFromStorage = (key) => {
        try {
            const storedTicket = sessionStorage.getItem(key)
            return storedTicket ? JSON.parse(storedTicket) : {
                arrivalCode: '',
                arrivalName:'',
                arrivalDate: '',
                arrivalTime: '',
                price: '',
                departureCode: '',
                departureName: '',
                departureDate: '',
                departureTime: '',
                flightNumber: '',
                selectedClass: '',
                adults: 0,
                children: 0
            }
        } catch (error) {
            console.error('Error retrieving ticket from sessionStorage:', error)
            return {
                arrivalCode: '',
                arrivalName:'',
                arrivalDate: '',
                arrivalTime: '',
                price: '',
                departureCode: '',
                departureName: '',
                departureDate: '',
                departureTime: '',
                flightNumber: '',
                selectedClass: '',
                adults: 0,
                children: 0
            }
        }
    }

    // Reactive references for departure and arrival tickets
    const selectedDeparture = ref(getTicketFromStorage('departureTicket'))
    const selectedArrival = ref(getTicketFromStorage('arrivalTicket'))

    // Save departure ticket
    const saveDepartureTicket = (selectedTicket) => {
        selectedDeparture.value = {...selectedTicket}
        saveTicketToStorage('departureTicket', selectedTicket)
    }

    // Save arrival ticket
    const saveArrivalTicket = (selectedTicket) => {
        selectedArrival.value = {...selectedTicket}
        saveTicketToStorage('arrivalTicket', selectedTicket)
    }

    // Get selected arrival ticket
    const getSelectedArrival = () => {
        return selectedArrival.value
    }

    // Get selected departure ticket
    const getSelectedDeparture = () => {
        return selectedDeparture.value
    }

    return {
        saveDepartureTicket, 
        saveArrivalTicket, 
        getSelectedArrival, 
        getSelectedDeparture
    }
})