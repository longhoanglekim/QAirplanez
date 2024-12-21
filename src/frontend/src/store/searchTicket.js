import { defineStore } from 'pinia'
import { ref } from 'vue'

export const searchTicketStore = defineStore('searchTicket-store', () => {
    const form = ref({
        seatCode: '',
        firstName: ''
    })

    const saveForm = (submittedForm) => {
        form.value = { ...submittedForm }
        sessionStorage.setItem('ticketSearchForm', JSON.stringify(form.value))
    }

    const getOldForm = () => {
        const savedForm = sessionStorage.getItem('ticketSearchForm')
        if (savedForm) {
            form.value = JSON.parse(savedForm)
        }
        return form.value
    }

    const deleteForm = () => {
        form.value = {
            seatCode: '',
            firstName: ''
        }
        sessionStorage.removeItem('ticketSearchForm') // Clear from sessionStorage
    }

    return {
        saveForm,
        getOldForm,
        deleteForm
    }
})
