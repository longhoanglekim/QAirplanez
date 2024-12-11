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

    <AircraftStat />
    <AddAircraftModal :isModalOpen="isModalOpen && !isEditing" @close="closeModal" @add-aircraft="saveAircraft" />
    <EditAircraftModal :isModalOpen="isModalOpen && isEditing" @close="closeModal" @save="saveAircraft" />

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
            <tr v-for="plane in sortedAircraft" :key="plane.id"
                class="even:bg-gray-100 odd:bg-white">
                <td class=" p-2">{{ plane.id }}</td>
                <td class=" p-2">{{ plane.model }}</td>
                <td class=" p-2">{{ plane.capacity }}</td>
                <td class=" p-2">{{ plane.status }}</td>
                <td class=" p-2 relative">
                    <div class="relative">
                        <button @click="toggleDropdown(plane)" class="bg-blue-500 text-white p-1 rounded">
                            Hành Động
                        </button>
                        <div v-if="openDropdownId === plane.id" class="absolute right-0 mt-2 w-48 bg-white border rounded shadow-lg z-10">
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
import {
    aircraft
} from '../../../assets/data'
import AircraftStat from './AircraftStat.vue'
// Reactive state
const isModalOpen = ref(false)
const isEditing = ref(false)
const currentAircraft = ref({
    id: '',
    model: '',
    capacity: 0,
    status: 'Active'
})
const sortKey = ref('')
const sortOrder = ref('asc')
const openDropdownId = ref(null)

// Sorting function
const sortedAircraft = computed(() => {
    if (!sortKey.value) return aircraft

    return [...aircraft].sort((a, b) => {
        let modifier = sortOrder.value === 'asc' ? 1 : -1
        if (a[sortKey.value] < b[sortKey.value]) return -1 * modifier
        if (a[sortKey.value] > b[sortKey.value]) return 1 * modifier
        return 0
    })
})

// Dropdown toggle
const toggleDropdown = (plane) => {
  openDropdownId.value = openDropdownId.value === plane.id ? null : plane.id
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
  currentAircraft.value = {...plane}
  isEditing.value = true
  isModalOpen.value = true
  openDropdownId.value = null
}

const closeModal = () => {
  isModalOpen.value = false
}

const saveAircraft = () => {
  if (isEditing.value) {
    const index = aircraft.findIndex(a => a.id === currentAircraft.value.id)
    if (index !== -1) {
      aircraft[index] = {...currentAircraft.value}
    }
  } else {
    aircraft.push({...currentAircraft.value})
  }
  isModalOpen.value = false
}

const deleteAircraft = (plane) => {
  const index = aircraft.findIndex(a => a.id === plane.id)
  if (index !== -1) {
    aircraft.splice(index, 1)
  }
  openDropdownId.value = null
}
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