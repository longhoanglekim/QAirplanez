import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/User/LoginUser.vue";
import SignUpUser from "@/view/User/SignUpUser.vue";
import HomeUser from "@/view/User/HomeUser.vue";
import SearchResult from "@/view/User/SearchResult.vue";
import HomeAdmin from "@/view/Admin/HomeAdmin.vue";
import LoginAdmin from "@/view/Admin/Login.vue";

const routes = [
    {
        path: '/',
        redirect : '/home'
    },
    {
        path : '/home',
        name : 'HomeUser',
        component : HomeUser,
        meta: {
            guest: true
          }
    },
    {
        path : '/login',
        name : 'LoginUser',
        component: LoginUser,
        meta: {
            guest: true
          }
    }, {
        path : '/signup',
        name : 'SignUp',
        component : SignUpUser,
        meta: {
            guest: true
          }
    }, {
        path : '/booking/avaibility/0',
        name : 'SearchResult',
        component : SearchResult,
        meta: {
            guest: true
          }
    }, {
        path :'/admin',
        name : 'Admin',
        children: [
            { 
                path: '', name: 'login', component: LoginAdmin 
            },
            {
                path: 'dashboard', name: 'dashboard', component: HomeAdmin
            }
          ],
        meta: {
            requiresAuth: true,
            is_admin : true
          }
    }

];
const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;