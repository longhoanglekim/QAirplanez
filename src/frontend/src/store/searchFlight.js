import { defineStore } from "pinia";
import { ref } from "vue";

export const searchFlightStore = defineStore('searchFlight', () => {
    const form = ref({
        ticketType: 'round-trip',
        fromCity: '',
        toCity: '',
        departureDate: '',
        returnDate: '',
        adults: 1,
        children: 0
    })
    const saveForm = (submittedForm) => {
        form.value = {...submittedForm}
    }

    const getOldForm = () => {
        return form.value
    }

    const deleteForm = () => {
        form.value = {
            ticketType: 'round-trip',
            fromCity: '',
            toCity: '',
            departureDate: '',
            returnDate: '',
            adults: 1,
            children: 0
        }
    }

    return {
        saveForm, getOldForm, deleteForm
    }
})
