import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/LoginUser.vue";
import SignUpUser from "@/view/SignUpUser.vue";
import HomeUser from "@/view/HomeUser.vue";
import SearchResult from "@/view/SearchResult.vue";

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
        name : 'SignUp',
        component : SignUpUser
    }, {
        path : '/booking/avaibility/0',
        name : 'SearchResult',
        component : SearchResult
    }

];
const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;