import HomePage from "@/components/HomePage.vue";
import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/components/LoginUser.vue";

const routes = [
    {
        path: '/',
        redirect : '/login_user'
    },
    {
        path : '/home',
        name : 'HomePage',
        component : HomePage
    },
    {
        path : '/login_user',
        name : 'LoginUser',
        component: LoginUser
    }


];
const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;