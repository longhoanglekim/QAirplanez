<template>
<div class="flex h-screen ">
    <!-- Navbar start -->
    <nav id="navbar" class="fixed top-0 z-30  w-full flex flex-row justify-start bg-gray-700 p-3 sm:justify-between">
      <button id="btnSidebarToggler" @click="toggleSidebar" type="button" class=" text-2xl text-white hover:text-gray-200">
        <align-justify v-if="!sideBarIsOpening" class="z-50 stroke-4 hover:stroke-blue-500"/>
        
      </button>
      <span>&nbsp;</span>
      <ul class="breadcrumb hidden flex-row flex-grow sm:justify-center items-center  text-lg text-white sm:flex">
        <li class="inline">
            <a href="#">Main</a>
        </li>
        <li class="inline">
            <span>Homepage</span>
        </li>
      </ul>
      
    </nav>
    <!-- Navbar end -->
    <!-- Sidebar -->
    <div class="z-40 w-64 h-full text-white p-4 bg-slate-600 transition-all duration-300 ease-in-out"
        :class="sideBarIsOpening ? 'max-w-screen opacity-100 p-0' : 'max-w-0 opacity-0 p-0 -z-0'" >
        <h1 class="text-2xl font-bold mb-6 flex relative">
            <span>QAirline</span>
            <X @click="toggleSidebar" class="absolute right-0 w-8 h-8 border-2 border-white"/> 
        </h1>
        <nav class="space-y-4">
            <button class="rounded-lg "
            v-for="item in menuItems" :key="item.key" @click="changeSection(item.key)" :class="[
            'flex items-center w-full p-0',
            activeSection === item.key ? 'bg-gray-700' : 'bg-white/10 hover:bg-gray-700'
          ]">
                <div class="flex items-center p-4 w-full rounded-lg hover:translate-x-1 hover:-translate-y-1 hover:bg-red-800" 
                    :class="[activeSection === item.key ? 'bg-orange-600  translate-x-1 -translate-y-1' : ' hover:bg-gray-700']">
                    <component :is="item.icon" class="mr-2" /> {{ item.label }}
                </div>
            </button>
        </nav>
        <button id="btnSidebarToggler" @click="toggleSidebar" type="button" class="place-self-center my-16 text-2xl text-white hover:text-gray-200">
          <ArrowLeftFromLine class="z-50 stroke-4 hover:stroke-blue-500"/>
        </button>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-16 bg-amber-50 overflow-y-auto transition-all duration-300">
        <component :is="currentComponent" />
    </div>
</div>
</template>

<script setup>
import {
    ref,
    computed
} from 'vue'
import {
    LayoutDashboard,
    Plane,
    Users,
    CalendarCheck,
    ArrowLeftFromLine ,
    AlignJustify,
    X,
    Newspaper
} from 'lucide-vue-next'
import DashBoard from '@/components/Admin/DashBoard.vue'
import AircraftManagement from '@/components/Admin/Aircraft/AircraftManagement.vue'
import FlightManagement from '@/components/Admin/Flight/FlightManagement.vue'
import PassengerManagement from '@/components/Admin/Passenger/PassengerManagement.vue'
import NewsManagement from '@/components/Admin/News/NewsManagement.vue'
const activeSection = ref('dashboard')

const changeSection = (section) => {
    activeSection.value = section
}

const sideBarIsOpening = ref(true)
const toggleSidebar = () => {
  sideBarIsOpening.value = !sideBarIsOpening.value
}

const menuItems = [{
        key: 'dashboard',
        label: 'Tổng Quan',
        icon: LayoutDashboard
    },
    {
        key: 'news',
        label: 'Trang tin',
        icon: Newspaper
    },
    {
        key: 'aircraft',
        label: 'Máy Bay',
        icon: Plane
    },
    {
        key: 'flights',
        label: 'Chuyến Bay',
        icon: CalendarCheck
    },
    {
        key: 'passengers',
        label: 'Hành Khách',
        icon: Users
    }
]

const currentComponent = computed(() => {
    const componentMap = {
        'dashboard': DashBoard,
        'aircraft': AircraftManagement,
        'flights': FlightManagement,
        'passengers': PassengerManagement,
        'news': NewsManagement
    }
    return componentMap[activeSection.value]
})
</script>

<style scoped>
  
    ul.breadcrumb li+li::before {
        content: "\276F";
        padding-left: 8px;
        padding-right: 4px;
        color: inherit;
    }

    ul.breadcrumb li span {
        opacity: 60%;
    }
</style>