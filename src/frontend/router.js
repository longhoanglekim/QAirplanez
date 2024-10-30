import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/LoginUser.vue";
import SignUpUser from "@/view/SignUpUser.vue";
import HomeUser from "@/view/HomeUser.vue";

const routes = [
    {
        path: '/',
        redirect : '/home'
    },
    {
        path : '/home',
        name : 'HomeUser',
        component : HomeUser
    },
    {
        path : '/login',
        name : 'LoginUser',
        component: LoginUser
    }, {
        path : '/signup',
        name : 'Sign Up',
        component : SignUpUser
    }

];
const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;