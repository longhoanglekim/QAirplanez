<template>
  <div>
    <h2 class="text-xl font-bold mb-4">Quản Lý Máy Bay</h2>
    <div class="mb-4">
      <div class="flex items-center bg-white rounded-lg border p-2 max-w-md">
        <input
            type="text"
            placeholder="Tìm kiếm theo tên máy bay..."
            class="flex-1 outline-none px-2"
            v-model="searchQuery"
        />
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
        </svg>
      </div>
      <div class="flex justify-start mt-5">
        <!-- Nút thêm máy bay -->
        <button @click="openAddModal" class="place-self-end bg-green-500 text-white p-2 rounded mb-4">
          Thêm Máy Bay
        </button>
      </div>
    </div>
    <!-- Stat -->
    <AircraftStat :aircraft="aircraftList" :key="reloadStat"/>
    
    <AddAircraftModal v-if="isModalOpen && !isEditing" @finish-add-aircraft="finishAddAircraft" @close="closeModal" />
    <EditAircraftModal v-if="isModalOpen && isEditing" :current-aircraft="currentAircraft" @close="closeModal" @save="saveAircraft"/>

    <!-- Bảng máy bay -->
    <table class="w-full border rounded-xl bg-white p-0 ">
      <thead class="rounded-t-xl bg-gray-200">
      <tr>
        <th class=" p-2 cursor-pointer" @click="sortBy('id')">
          Mã Máy Bay
          <span v-if="sortKey === 'id'">
                        {{ sortOrder === 'asc' ? '▲' : '▼' }}
                    </span>
        </th>
        <th class=" p-2 cursor-pointer" @click="sortBy('model')">
          Mô Hình
          <span v-if="sortKey === 'model'">
                        {{ sortOrder === 'asc' ? '▲' : '▼' }}
                    </span>
        </th>
        <th class=" p-2 cursor-pointer" @click="sortBy('capacity')">
          Sức Chứa
          <span v-if="sortKey === 'capacity'">
                        {{ sortOrder === 'asc' ? '▲' : '▼' }}
                    </span>
        </th>
        <th class=" p-2 cursor-pointer" @click="sortBy('status')">
          Trạng Thái
          <span v-if="sortKey === 'status'">
                        {{ sortOrder === 'asc' ? '▲' : '▼' }}
                    </span>
        </th>
        <th class=" p-2">Hành Động</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="plane in sortedAircraft" :key="plane.serialNumber"
          class="even:bg-gray-100 odd:bg-white">
        <td class=" p-2">{{ plane.serialNumber }}</td>
        <td class=" p-2">{{ plane.aircraftCode }}</td>
        <td class=" p-2">{{ plane.numberOfSeats }}</td>
        <td class=" p-2" :class="'text-' + getStatusColor(plane.status)">
          <div class="flex items-center space-x-2 justify-center">
            <Dot class="w-2 h-2 rounded" :class="'bg-' + getStatusColor(plane.status)"></Dot>
            <span>{{ getStatus(plane.status) }}</span>
          </div>
        </td>
        <td class=" p-2 relative">
          <div class="relative">
            <button @click="toggleDropdown(plane)" class="bg-blue-500 text-white p-1 rounded">
              Hành Động
            </button>
            <div v-if="openDropdownId === plane.serialNumber" class="absolute right-0 mt-2 w-48 bg-white border rounded shadow-lg z-10">
              <div @click="startEdit(plane)" class="p-2 hover:bg-gray-100 cursor-pointer">
                Chỉnh Sửa
              </div>
              <div @click="deleteAircraft(plane)" class="p-2 hover:bg-gray-100 text-red-500 cursor-pointer">
                Xóa
              </div>
            </div>
          </div>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import {
  ref,
  computed,
  onMounted
} from 'vue'
import AircraftStat from './AircraftStat.vue'
import AddAircraftModal from "@/components/Admin/Aircraft/AddAircraftModal.vue";
import EditAircraftModal from "@/components/Admin/Aircraft/EditAircraftModal.vue";
import { Dot    } from 'lucide-vue-next';
import { useAircraftStore } from '@/store/aircraftstore'
// Reactive state
const isModalOpen = ref(false)
const isEditing = ref(false)
const currentAircraft = ref({
  id: '',
  model: '',
  capacity: 0,
  status: 'Active'
})

const storeAircraft = useAircraftStore()

const sortKey = ref('')
const sortOrder = ref('asc')
const openDropdownId = ref(null)
const reloadStat = ref(0)
// Add aircraft ref
const aircraftList = ref(storeAircraft.getAircraft())

// Add refreshAircraftData function
const refreshAircraftData = async () => {
  await storeAircraft.reloadAircraft()
  aircraftList.value = storeAircraft.getAircraft()
}


const getStatus = (status) => {
  if (status === 'Active') return 'Đang rảnh'
  if (status === 'Maintenance') return 'Được lên lịch'
  if (status === 'Inactive') return 'Sửa chữa'
}

const getStatusColor = (status) => {
  if (status === 'Active') return 'green-500'
  if (status === 'Maintenance') return 'yellow-500'
  if (status === 'Inactive') return 'red-500'
}
// Update sortedAircraft computed to use aircraftList instead of imported aircraft
const sortedAircraft = computed(() => {
  if (!sortKey.value) return aircraftList.value

  return [...aircraftList.value].sort((a, b) => {
    let modifier = sortOrder.value === 'asc' ? 1 : -1
    if (a[sortKey.value] < b[sortKey.value]) return -1 * modifier
    if (a[sortKey.value] > b[sortKey.value]) return 1 * modifier
    return 0
  })
})

// Dropdown toggle
const toggleDropdown = (plane) => {
  openDropdownId.value = openDropdownId.value === plane.serialNumber ? null : plane.serialNumber
}

// Close dropdowns when clicking outside
onMounted(() => {
  const closeDropdown = (event) => {
    const actionButtons = document.querySelectorAll('button')
    const isClickInsideDropdown = Array.from(actionButtons).some(button =>
        button.contains(event.target)
    )

    if (!isClickInsideDropdown) {
      openDropdownId.value = null
    }
  }

  document.addEventListener('click', closeDropdown)

  // Cleanup listener on component unmount
  return () => {
    document.removeEventListener('click', closeDropdown)
  }
})

// Rest of the previous methods remain the same
const sortBy = (key) => {
  if (sortKey.value === key) {
    sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc'
  } else {
    sortKey.value = key
    sortOrder.value = 'asc'
  }
}

const openAddModal = () => {
  currentAircraft.value = {
    id: '',
    model: '',
    capacity: 0,
    status: 'Active'
  }
  isEditing.value = false
  isModalOpen.value = true
}

const startEdit = (plane) => {
  currentAircraft.value = {
    serialNumber: plane.serialNumber,
    model: plane.model,
    manufacturer: plane.manufacturer,
    numberOfSeats: plane.numberOfSeats,
    status: plane.status
  }
  isEditing.value = true
  isModalOpen.value = true
  openDropdownId.value = null
}

const closeModal = () => {
  isModalOpen.value = false
}

const finishAddAircraft = async () => {
  await refreshAircraftData()
  closeModal()
}

const saveAircraft = async (editedAircraft) => {
  if (isEditing.value) {
    console.log('editedAircraft: ', editedAircraft)
    try {
      await storeAircraft.editAircraft(editedAircraft)
      await refreshAircraftData()
      closeModal()
    } catch (error) {
      alert('Error editing aircraft:', error);
    }
  }
}

const deleteAircraft = async (plane) => {
  await storeAircraft.deleteAircraft(plane)
  await refreshAircraftData()
  openDropdownId.value = null
}

// Call refreshAircraftData on component mount
onMounted( async () => {
  await refreshAircraftData()
})
</script>

<style  scoped>
table {
  border-collapse:separate;
  border-radius:6px;
}


th {
  border-top: none;
}

td:first-child, th:first-child {
  border-left: none;
}
</style>