import { defineStore } from "pinia";
import { ref } from "vue";

export const authStore = defineStore('account', ()=> {
    const user = ref({
        role: 'guest',
        username: '',
        password: '',
    })

    const getRole = () => {
        return user.value.role
    }

    const saveLogin = (loggedUser) => {
        user.value = {...loggedUser};
    }


    return {getRole, saveLogin};
})