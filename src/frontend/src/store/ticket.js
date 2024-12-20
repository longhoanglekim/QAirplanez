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

    const saveAdultInformation = (information) => {
        sessionStorage.setItem('adultInformation', JSON.stringify(information))
    }

    const saveChildInformation = (information) => {
        sessionStorage.setItem('childInformation', JSON.stringify(information))
    }

    const getAdultInformation = () => {
        return JSON.parse(sessionStorage.getItem('adultInformation'))
    }

    const getChildInformation = () => {
        return JSON.parse(sessionStorage.getItem('childInformation'))
    }

    const getPassengerDepartureInformation = (seatsSelected) => {
        const adultInformation = getAdultInformation()
        const childInformation = getChildInformation()
        const passengerInfoList = []
        let j = 0
        for(let i = 0; i < adultInformation.length; i++) {
            passengerInfoList.push({
                firstName: adultInformation[i].firstName,
                lastName: adultInformation[i].lastName,
                birthdate: adultInformation[i].birthDate,
                gender: adultInformation[i].gender,
                identification: adultInformation[i].cccd,
                phoneNumber: adultInformation[i].phone,
                email: adultInformation[i].email,
                ticketClassCode: getSelectedDeparture().selectedClass.charAt(0).toUpperCase() + getSelectedDeparture().selectedClass.slice(1), //"economy" to "Economy"
                seatRow: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).row : '',
                seatPosition: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).position : ''
            })
            j++
        }
        for(let i = 0; i < childInformation.length; i++) {
            passengerInfoList.push({
                firstName: childInformation[i].firstName,
                lastName: childInformation[i].lastName,
                birthDate: childInformation[i].birthDate,
                ticketClassCode: getSelectedDeparture().selectedClass,
                gender: childInformation[i].gender,
                seatRow: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).row : '',
                seatPosition: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).position : ''
            })
            j++
        }
        return passengerInfoList
    }

    const getPassengerReturnInformation = (seatsSelected) => {
        const adultInformation = getAdultInformation()
        const childInformation = getChildInformation()
        const passengerInfoList = []
        let j = 0
        for(let i = 0; i < adultInformation.length; i++) {
            passengerInfoList.push({
                firstName: adultInformation[i].firstName,
                lastName: adultInformation[i].lastName,
                birthdate: adultInformation[i].birthDate,
                gender: adultInformation[i].gender,
                identification: adultInformation[i].cccd,
                phoneNumber: adultInformation[i].phone,
                email: adultInformation[i].email,
                ticketClassCode: getSelectedArrival().selectedClass.charAt(0).toUpperCase() + getSelectedArrival().selectedClass.slice(1), //"economy" to "Economy"
                seatRow: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).row : '',
                seatPosition: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).position : ''
            })
            j++
        }
        for(let i = 0; i < childInformation.length; i++) {
            passengerInfoList.push({
                firstName: childInformation[i].firstName,
                lastName: childInformation[i].lastName,
                birthDate: childInformation[i].birthDate,
                ticketClassCode: getSelectedArrival().selectedClass.charAt(0).toUpperCase() + getSelectedArrival().selectedClass.slice(1), //"economy" to "Economy"
                gender: childInformation[i].gender,
                seatRow: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).row : '',
                seatPosition: j < seatsSelected.length ? getRowAndPosition(seatsSelected[j]).position : ''
            })
            j++
        }
        return passengerInfoList
    }

    const getRowAndPosition = (seat) => {
        //seat = "D-1"
        const row = seat.split('-')[1]
        const position = seat.split('-')[0]
        return {row, position}  
    }

    return {
        saveDepartureTicket, 
        saveArrivalTicket, 
        getSelectedArrival, 
        getSelectedDeparture,
        saveAdultInformation,
        saveChildInformation,
        getAdultInformation,
        getChildInformation,
        getPassengerDepartureInformation,
        getPassengerReturnInformation
    }
})