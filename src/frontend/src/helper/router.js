import {createRouter, createWebHistory} from "vue-router";
import LoginUser from "@/view/User/LoginUser.vue";
import SignUpUser from "@/view/User/SignUpUser.vue";
import HomeUser from "@/view/User/home/HomeUser.vue";
import SearchFlightResult from "@/view/User/bookTicket/SearchFlightResult.vue";
import HomeAdmin from "@/view/Admin/HomeAdmin.vue";
import LoginAdmin from "@/view/Admin/LoginAdmin.vue";
import ExploreUser from "@/view/User/home/ExploreUser.vue";
import TestComponent from "@/view/Test/TestComponent.vue";
import ProfileUser from "@/view/User/ProfileUser.vue";
import SearchFlightArrival from "@/view/User/bookTicket/SearchFlightArrival.vue";
import InformationForm from "@/view/User/bookTicket/InformationForm.vue";
import SearchSeatResult from "@/view/User/SearchSeatResult.vue";
import SubService from "@/view/User/bookTicket/SubService.vue";
import SuccessBooking from "@/view/User/bookTicket/SuccessBooking.vue";

import ImageTest from "@/view/Test/ImageTest.vue";
import LogoutUser from "@/view/User/LogoutUser.vue"

import BangTest from "@/view/Test/BangTest.vue";
import NewsUser from "@/view/User/NewsUser.vue";
import NewsItem from "@/components/User/news/NewsItem.vue";
import DestinationDetail from "@/components/User/destination/DestinationDetail.vue";

import { useUIStore } from "@/store/UIstore";

const routes = [
    {
        path: '/test',
        component: TestComponent,
        meta: {
            test: true
        }
    }, {
        path: '/bangtest',
        component: BangTest,
        meta: {
            test: true
        }
    },
    {
      path: '/testImage',
      component: ImageTest,
      meta: {
          test: true
      }
    },
    {
        path: '/logout',
        component: LogoutUser,
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
            guest: true,
            login: true,
          }
    }, {
        path : '/signup',
        name : 'SignUp',
        component : SignUpUser,
        meta: {
            guest: true,
            signup: true
          }
    }, {
        path : '/booking/availability/0',
        name : 'SearchFlightResult',
        component : SearchFlightResult,
        meta: {
            guest: true
          }
    }, {
        path : '/booking/availability/1',
        name : 'SearchFlightArrival',
        component : SearchFlightArrival,
        meta: {
            guest: true
          }
    }, {
        path: '/booking/information/1',
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
        path: '/booking/information/3/:bookingCode',
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
        path : '/news',
        name: 'News',
        component: NewsUser,
    }, {
      path: '/news/:title',
      name: 'NewsItem',
      component: NewsItem,
      props: true
    }
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

function isLoggedInAdmin() {
  const adminToken = localStorage.getItem('adminToken');
  return adminToken != null;
}

function isLoggedInUser() {
    return localStorage.getItem('token') != null;
}

router.beforeEach((to, from, next) => {
  const uiStore = useUIStore()
  uiStore.isLoading = true
    // Handle admin routes
    if (to.path.startsWith('/admin')) {
      // If not logged in as admin
      if (!isLoggedInAdmin()) {
        // Redirect to admin login if not on login page
        if (to.path !== '/admin/login') {
          return next('/admin/login');
        }
        return next();
      } 
      
      // If logged in as admin
      if (to.path === '/admin/login') {
        // Redirect to dashboard if on login page
        return next('/admin/dashboard');
      }
      
      // Allow access to other admin routes
      return next();
    }
  
    // Xử lý route user
    if (to.matched.some((record) => record.meta.requiresAuth)) {
      // Nếu chưa đăng nhập user
      if (!isLoggedInUser()) {
        // Chuyển sang trang login nếu không phải trang login
        if (to.path !== '/login') {
          setTimeout(()=>{
            next('/login')
          },800)
        }
        setTimeout(()=>{
          next()
        },800)
      }
      
      // Nếu đã đăng nhập user
      if (to.path === '/login') {
        // Chuyển sang dashboard nếu đang ở trang login
        return next('/home');
      }
      setTimeout(() => {
        next()
      }, 800)
      // Cho phép đi tiếp các route yêu cầu xác thực
    }
  
    // Cho phép đi tiếp các route không yêu cầu xác thực
    setTimeout(() => {
      next()
    }, 800)
    
  });

export default router;


router.afterEach(() => {
  const uiStore = useUIStore()
  uiStore.isLoading = false
})
