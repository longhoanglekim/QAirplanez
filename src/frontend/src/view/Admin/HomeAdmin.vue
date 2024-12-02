<template>
<div class="flex h-screen ">
    <!-- Navbar start -->
    <nav id="navbar" class="fixed top-0 z-30  w-full flex flex-row justify-start bg-gray-700 p-3 sm:justify-between">
      <button id="btnSidebarToggler" @click="toggleSidebar" type="button" class=" text-2xl text-white hover:text-gray-200">
        <align-justify v-if="!sideBarIsOpening" class="z-50 stroke-4 hover:stroke-blue-500"/>
      </button>
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
    <div v-if="sideBarIsOpening" class="z-40 fixed md:relative h-full md:block w-64 bg-gray-800 text-white p-4" >
        <h1 class="text-2xl font-bold mb-6">Quản Lý Hãng Bay</h1>
        <nav>
            <button v-for="item in menuItems" :key="item.key" @click="changeSection(item.key)" :class="[
            'flex items-center w-full p-3',
            activeSection === item.key ? 'bg-blue-600' : 'hover:bg-gray-700'
          ]">
                <component :is="item.icon" class="mr-2" /> {{ item.label }}
            </button>
        </nav>
        <button id="btnSidebarToggler" @click="toggleSidebar" type="button" class="place-self-center my-16 text-2xl text-white hover:text-gray-200">
          <ArrowLeftFromLine v-if="sideBarIsOpening" class="z-50 stroke-4 hover:stroke-blue-500"/>
        </button>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-16 bg-amber-50 overflow-y-auto">
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
    AlignJustify 
} from 'lucide-vue-next'
import DashBoard from '@/components/Admin/DashBoard.vue'
import AircraftManagement from '@/components/Admin/AircraftManagement.vue'
import FlightManagement from '@/components/Admin/FlightManagement.vue'
import PassengerManagement from '@/components/Admin/PassengerManagement.vue'

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
        'passengers': PassengerManagement
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