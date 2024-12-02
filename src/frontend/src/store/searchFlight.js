import { defineStore } from "pinia";
import { ref } from "vue";

export const searchFlightStore = defineStore('searchFlight', () => {
    const form = ref({
        ticketType: sessionStorage.getItem('ticketType') || 'round-trip',
        fromCity: sessionStorage.getItem('fromCity') || '',
        toCity: sessionStorage.getItem('toCity') || '',
        departureDate: sessionStorage.getItem('departureDate') || '',
        returnDate: sessionStorage.getItem('returnDate') || '',
        adults: Number(sessionStorage.getItem('adults')) || 1,
        children: Number(sessionStorage.getItem('children')) || 0
    });

    const lastSearch = ref({
        fromCity: sessionStorage.getItem('lastFromCity') || '',
        toCity: sessionStorage.getItem('lastToCity') || '',
        departureDate: sessionStorage.getItem('lastDepartureDate') || '',
        numOfTicket: sessionStorage.getItem('lastNumOfTicket') || ''
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
        lastSearch.value = {
            fromCity: submittedForm.fromCity,
            toCity: submittedForm.toCity,
            departureDate: submittedForm.departureDate,
            numOfTicket: submittedForm.adults + submittedForm.children
        };
        sessionStorage.setItem('lastFromCity', lastSearch.value.fromCity);
        sessionStorage.setItem('lastToCity', lastSearch.value.toCity);
        sessionStorage.setItem('lastDepartureDate', lastSearch.value.departureDate);
        sessionStorage.setItem('lastNumOfTicket', lastSearch.value.numOfTicket.toString());
    };

    const getOldForm = () => {
        return form.value;
    };

    const getLastSearch = () => {
        return lastSearch.value;
    };

    const reverseSearch = () => {
        let temp = lastSearch.value.fromCity;
        lastSearch.value.fromCity = lastSearch.value.toCity;
        lastSearch.value.toCity = temp;
        lastSearch.value.departureDate = form.value.returnDate;
        sessionStorage.setItem('lastFromCity', lastSearch.value.fromCity);
        sessionStorage.setItem('lastToCity', lastSearch.value.toCity);
        sessionStorage.setItem('lastDepartureDate', lastSearch.value.departureDate);
        return lastSearch.value;
    };

    const deleteForm = () => {
        form.value = {
            ticketType: 'round-trip',
            fromCity: '',
            toCity: '',
            departureDate: '',
            returnDate: '',
            adults: 1,
            children: 0
        };
        lastSearch.value = {
            fromCity: '',
            toCity: '',
            departureDate: '',
            numOfTicket: ''
        };
        const keysToRemove = [
            'ticketType', 'fromCity', 'toCity', 'departureDate', 'returnDate', 
            'adults', 'children', 'lastFromCity', 'lastToCity', 
            'lastDepartureDate', 'lastNumOfTicket'
        ];
        keysToRemove.forEach(key => sessionStorage.removeItem(key));
    };

    return {
        form,
        lastSearch,
        saveForm, 
        getOldForm, 
        deleteForm, 
        getLastSearch, 
        reverseSearch
    };
});
