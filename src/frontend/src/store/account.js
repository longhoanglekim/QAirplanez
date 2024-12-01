import { defineStore } from "pinia";
import { ref } from "vue";

export const authStore = defineStore('account', ()=> {
    const user = ref({
        role: 'guest',
        email: '',
        firstName: '',
        lastname: '',
        password: '',
        phone: ''
    })

    const getRole = () => {
        return user.value.role
    }

    const saveUser = (loggedUser) => {
        user.value = {...loggedUser};
    }

    const logout = () => {
        user.value = {
            role: 'guest',
            email: '',
            firstName: '',
            lastname: '',
            password: '',
            phone: ''
        }
    }

    return {getRole, saveUser, logout};
})