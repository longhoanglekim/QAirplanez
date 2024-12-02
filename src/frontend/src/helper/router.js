import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/User/LoginUser.vue";
import SignUpUser from "@/view/User/SignUpUser.vue";
import HomeUser from "@/view/User/HomeUser.vue";
import SearchFlightResult from "@/view/User/SearchFlightResult.vue";
import HomeAdmin from "@/view/Admin/HomeAdmin.vue";
import LoginAdmin from "@/view/Admin/LoginAdmin.vue";
import ExploreUser from "@/view/User/ExploreUser.vue";
import DestinationDetail from "@/view/User/destinations/DestinationDetail.vue"
import TestComponent from "@/view/Test/TestComponent.vue";
import SearchSeatResult from "@/view/User/SearchSeatResult.vue";
import ProfileUser from "@/view/User/ProfileUser.vue";
import ChangePassword from "@/components/User/profileUser/ChangePassword.vue";


const routes = [
    {
        path: '/test',
        component: TestComponent,
        meta: {
            test: true
        }
    },
    {
        path: '/',
        redirect : '/home',
        props: true
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
        name : 'SearchFlightResult',
        component : SearchFlightResult,
        meta: {
            guest: true
          }
    }, {
        path: '/booking/done/0',
        name: 'SearchSeatResult',
        component : SearchSeatResult,
        meta: {
            guest: true
        }
    },
    {
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
    }, {
        path: '/user',
        name: 'Profile',
        component: ProfileUser,
    }, {
        path: '/password/change',
        name: 'ChangePassword',
        component: ChangePassword,
    },
];
const router = createRouter({
    history: createWebHistory(),
    routes, 
    scrollBehavior(to, from, savedPosition) {
        // Đảm bảo trang cuộn lên đầu mỗi lần thay đổi route
        if (savedPosition) {
          return savedPosition;
        } else {
          return { top:0, left:0 }; // Cuộn lên đầu trang
        }
      }
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