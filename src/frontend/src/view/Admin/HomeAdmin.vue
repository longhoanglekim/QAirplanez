<template>
  <div class="flex h-screen">
    <!-- Sidebar -->
    <div class="w-64 bg-gray-800 text-white p-4">
      <h1 class="text-2xl font-bold mb-6">Quản Lý Hãng Bay</h1>
      <nav>
        <button 
          v-for="item in menuItems" 
          :key="item.key"
          @click="changeSection(item.key)"
          :class="[
            'flex items-center w-full p-3',
            activeSection === item.key ? 'bg-blue-600' : 'hover:bg-gray-700'
          ]"
        >
          <component :is="item.icon" class="mr-2" /> {{ item.label }}
        </button>
      </nav>
      <button></button>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-6 bg-gray-100 overflow-y-auto">
      <component :is="currentComponent" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { 
  LayoutDashboard, 
  Plane, 
  Users, 
  CalendarCheck 
} from 'lucide-vue-next'
import DashBoard from '@/components/Admin/DashBoard.vue'
import AircraftManagement from '@/components/Admin/AircraftManagement.vue'
import FlightManagement from '@/components/Admin/FlightManagement.vue'
import PassengerManagement from '@/components/Admin/PassengerManagement.vue'

const activeSection = ref('dashboard')

const changeSection = (section) => {
  activeSection.value = section
}

const menuItems = [
  { key: 'dashboard', label: 'Tổng Quan', icon: LayoutDashboard },
  { key: 'aircraft', label: 'Máy Bay', icon: Plane },
  { key: 'flights', label: 'Chuyến Bay', icon: CalendarCheck },
  { key: 'passengers', label: 'Hành Khách', icon: Users }
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