import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/User/LoginUser.vue";
import SignUpUser from "@/view/User/SignUpUser.vue";
import HomeUser from "@/view/User/HomeUser.vue";
import SearchResult from "@/view/User/SearchResult.vue";
import HomeAdmin from "@/view/Admin/HomeAdmin.vue";
import LoginAdmin from "@/view/Admin/LoginAdmin.vue";
import ExploreUser from "@/view/User/ExploreUser.vue";
import DestinationDetail from "@/view/User/destinations/DestinationDetail.vue"



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
                path: 'login', name: 'LoginAdmin', component: LoginAdmin 
            },
            {
                path: 'dashboard', name: 'dashboard', component: HomeAdmin, meta: {
                    requiresAuth: true
                }
            }
          ],
        meta: {
            isAdminRoute : true
          }
    }
    , {
        path : '/explore',
        name: 'Explore',
        component: ExploreUser
    }, {
        path: '/explore/:destination',
        name: 'Destination',
        component: DestinationDetail,
        props: true,
    },
];
const router = createRouter({
    history: createWebHistory(),
    routes
});

// function isLoggedInAdmin() {
//     return false;
// }

// function isLoggedInUser() {
//     return false;
// }

// router.beforeEach((to, from, next) => {
    
//     if (to.path.startsWith('/admin')) {
//       if (!isLoggedInAdmin()) {
//         if (to.path != '/admin/login') next('/admin/login'); 
//         else next()
//       } else {
//         if (to.path == '/admin/login') next('/admin/dashboard');
//         else next(); 
//       }
//     } else if (to.matched.some((record) => record.meta.requiresAuth)) {
//       if (!isLoggedInUser()) {
//         next('/login');
//       } else {
//         next();
//       }
//     } else {
//       next(); 
//     }
//   });

export default router;