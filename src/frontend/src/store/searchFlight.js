import { defineStore } from "pinia";
import { ref } from "vue";

export const searchFlightStore = defineStore('searchFlight', () => {
    const form = ref({
        ticketType: sessionStorage.getItem('ticketType') || 'round-trip',
        fromCity: sessionStorage.getItem('fromCity') || '',
        fromCityName: sessionStorage.getItem('fromCityName') || '',
        toCity: sessionStorage.getItem('toCity') || '',
        toCityName: sessionStorage.getItem('toCityName') || '',
        departureDate: sessionStorage.getItem('departureDate') || '',
        returnDate: sessionStorage.getItem('returnDate') || '',
        adults: Number(sessionStorage.getItem('adults')) || 1,
        children: Number(sessionStorage.getItem('children')) || 0
    });

    const saveForm = (submittedForm) => {
        form.value = {...submittedForm};
        Object.keys(submittedForm).forEach(key => {
            sessionStorage.setItem(key, 
                typeof submittedForm[key] === 'number' 
                    ? submittedForm[key].toString() 
                    : submittedForm[key]
            );
        });
    };

    const getOldForm = () => {
        return form.value;
    };

    const deleteForm = () => {
        form.value = {
            ticketType: 'round-trip',
            fromCity: '',
            fromCityName: '',
            toCity: '',
            toCityName: '',
            departureDate: '',
            returnDate: '',
            adults: 1,
            children: 0
        };
        const keysToRemove = [
            'ticketType', 'fromCity', 'fromCityName', 'toCity', 'toCityName',
            'departureDate', 'returnDate', 'adults', 'children'
        ];
        keysToRemove.forEach(key => sessionStorage.removeItem(key));
    };

    return {
        saveForm, 
        getOldForm, 
        deleteForm, 
    };
});
