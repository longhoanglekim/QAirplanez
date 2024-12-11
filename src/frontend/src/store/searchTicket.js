import { defineStore } from "pinia";
import { ref } from "vue";

export const searchTicket = defineStore('searchFlight', () => {
    const form = ref({
        seatCode: '',
        firstName: ''
    })
    const saveForm = (submittedForm) => {
        form.value = {...submittedForm}
    }
    const getOldForm = () => {
        return form.value
    }

    // const deleteForm = () => {
    //     form.value = {
    //         seatCode: '',
    //         firstName: ''
    //     }
    // }

    return {
        saveForm, getOldForm
    }
})
