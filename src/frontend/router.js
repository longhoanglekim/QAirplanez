import HomePage from "@/components/HomePage.vue";
import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/components/LoginUser.vue";
import axios from "core-js/internals/queue";
import SignUpUser from "@/components/SignUpUser.vue";

const routes = [
    {
        path: '/',
        redirect : '/login_user'
    },
    {
        path : '/home',
        name : 'HomePage',
        component : HomePage,
        meta : {requiresAuth : true}
    },
    {
        path : '/login_user',
        name : 'LoginUser',
        component: LoginUser
    },
    {
        path : '/signup_user',
        name : 'SignUpUser',
        component: SignUpUser
    }


];
const router = createRouter({
    history: createWebHistory(),
    routes
});

router.beforeEach(async (to, from, next) => {
    const requiresAuth = to.matched.some(record => record.meta.requiresAuth);
    const token = localStorage.getItem('token');

    if (requiresAuth && !token) {
        next('/login_user');
    } else {
        if (token) {
            try {
                const response = await axios.get('/api/validate-token', {
                    headers: { Authorization: `Bearer ${token}` }
                });
                if (response.status === 200) {
                    next();
                } else {
                    throw new Error('Token invalid');
                }
            } catch (error) {
                console.error(error);
                localStorage.removeItem('token');
                next('/login_user'); // Nếu token không hợp lệ, chuyển về đăng nhập
            }
        } else {
            next();
        }
    }
});

export default router;