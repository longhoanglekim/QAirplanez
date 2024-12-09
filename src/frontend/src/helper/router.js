import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/User/LoginUser.vue";
import SignUpUser from "@/view/User/SignUpUser.vue";
import HomeUser from "@/view/User/home/HomeUser.vue";
import SearchFlightResult from "@/view/User/bookTicket/SearchFlightResult.vue";
import HomeAdmin from "@/view/Admin/HomeAdmin.vue";
import LoginAdmin from "@/view/Admin/LoginAdmin.vue";
import ExploreUser from "@/view/User/home/ExploreUser.vue";
import DestinationDetail from "@/view/User/destinations/DestinationDetail.vue"
import TestComponent from "@/view/Test/TestComponent.vue";
import ProfileUser from "@/view/User/ProfileUser.vue";
import SearchFlightArrival from "@/view/User/bookTicket/SearchFlightArrival.vue";
import InformationForm from "@/view/User/bookTicket/InformationForm.vue";
import SearchSeatResult from "@/view/User/SearchSeatResult.vue";
import MyProfile from "@/components/User/profileUser/Profile.vue";
import MyDashboard from "@/components/User/profileUser/Dashboard.vue";
import MyBookings from "@/components/User/profileUser/Bookings.vue";


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
        path : '/booking/avaibility/1',
        name : 'SearchFlightArrival',
        component : SearchFlightArrival,
        meta: {
            guest: true
          }
    }, {
        path: '/booking/infomation/1',
        name: 'InformationForm',
        component : InformationForm,
        meta: {
            guest: true
        }
    }, {
        path: '/booking/information/2',
        name: 'SubService',
        component : SubService,
        meta: {
            guest: true
        }
    }, {
        path: '/booking/information/3',
        name: 'SuccessBooking',
        component : SuccessBooking,
        meta: {
            guest: true
        }
    }, {
        path: '/booking/done/0',
        name: 'SearchSeatResult',
        component: SearchSeatResult,
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
    }, {
        path: '/user',
        name: 'Profile',
        children: [{
                path: 'dashboard',
                name: MyDashboard,
                component: MyDashboard,
            },{
                path: 'bookings',
                name: MyBookings,
                component: MyBookings,
            },{
                path: 'profile',
                name: MyProfile,
                component: MyProfile,
        }
        ],
        component: ProfileUser,
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