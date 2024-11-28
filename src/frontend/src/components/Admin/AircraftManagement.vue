<template>
    <div>
      <h2 class="text-xl font-bold mb-4">Quản Lý Máy Bay</h2>
      
      <!-- Thanh tìm kiếm và sắp xếp -->
      <div class="flex mb-4 space-x-4">
        <input 
          v-model="searchTerm" 
          placeholder="Tìm kiếm máy bay..." 
          class="flex-1 p-2 border rounded"
        />
        <select name="" v-model="searchCategory">
            <option value="">Tim kiem theo</option>
            <option value="id"></option>
            <option value="model"></option>
            <option value="capacity"></option>
            <option value="status"></option>
        </select>
        <select 
          v-model="sortBy" 
          class="p-2 border rounded"
        >
          <option value="">Sắp xếp theo</option>
          <option value="id">Mã Máy Bay</option>
          <option value="model">Mô Hình</option>
          <option value="capacity">Sức Chứa</option>
          <option value="status">Trạng Thái</option>
        </select>
        <button 
          @click="toggleSortOrder" 
          class="p-2 border rounded"
        >
          {{ sortOrder === 'asc' ? '▲' : '▼' }}
        </button>
      </div>
  
      <!-- Modal chỉnh sửa (giữ nguyên) -->
      <div v-if="editingAircraft" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg w-1/2">
          <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Máy Bay</h3>
          <div class="space-y-4">
            <input 
              v-model="editingAircraft.id" 
              placeholder="Mã Máy Bay" 
              class="w-full p-2 border rounded"
            />
            <input 
              v-model="editingAircraft.model" 
              placeholder="Mô Hình" 
              class="w-full p-2 border rounded"
            />
            <input 
              v-model.number="editingAircraft.capacity" 
              type="number" 
              placeholder="Sức Chứa" 
              class="w-full p-2 border rounded"
            />
            <select 
              v-model="editingAircraft.status" 
              class="w-full p-2 border rounded"
            >
              <option>Active</option>
              <option>Maintenance</option>
              <option>Inactive</option>
            </select>
            <div class="flex justify-end space-x-2">
              <button 
                @click="cancelEdit" 
                class="bg-gray-500 text-white p-2 rounded"
              >Hủy</button>
              <button 
                @click="saveAircraft" 
                class="bg-blue-500 text-white p-2 rounded"
              >Lưu</button>
            </div>
          </div>
        </div>
      </div>
  
      <!-- Bảng máy bay -->
      <table class="w-full border">
        <thead>
          <tr>
            <th 
              v-for="col in columns" 
              :key="col.key" 
              @click="updateSort(col.key)"
              class="border p-2 cursor-pointer hover:bg-gray-100"
            >
              {{ col.label }}
              <span v-if="sortBy === col.key">
                {{ sortOrder === 'asc' ? '▲' : '▼' }}
              </span>
            </th>
            <th class="border p-2">Hành Động</th>
          </tr>
        </thead>
        <tbody>
          <tr 
            v-for="plane in filteredAndSortedAircraft" 
            :key="plane.id"
          >
            <td class="border p-2">{{ plane.id }}</td>
            <td class="border p-2">{{ plane.model }}</td>
            <td class="border p-2">{{ plane.capacity }}</td>
            <td class="border p-2">{{ plane.status }}</td>
            <td class="border p-2">
              <button 
                @click="startEdit(plane)" 
                class="bg-blue-500 text-white p-1 rounded"
              >
                Chỉnh Sửa
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script setup>
  import { ref, computed } from 'vue'
  import { aircraft } from '@/assets/data'
  
  // Columns định nghĩa
  const columns = [
    { key: 'id', label: 'Mã Máy Bay' },
    { key: 'model', label: 'Mô Hình' },
    { key: 'capacity', label: 'Sức Chứa' },
    { key: 'status', label: 'Trạng Thái' }
  ]
  
  // State quản lý
  const searchTerm = ref('')
  const searchCategory = ref('')
  const sortBy = ref('')
  const sortOrder = ref('asc')
  const editingAircraft = ref(null)
  
  // Hàm tìm kiếm
  const filteredAndSortedAircraft = computed(() => {
    let result = aircraft.filter(plane => 
      Object.values(plane).some(val => 
        val.toString().toLowerCase().includes(searchTerm.value.toLowerCase())
      )
    )
  
    // Sắp xếp
    if (sortBy.value) {
      result.sort((a, b) => {
        let modifier = sortOrder.value === 'asc' ? 1 : -1
        return a[sortBy.value] > b[sortBy.value] ? modifier : -modifier
      })
    }
  
    return result
  })
  
  // Hàm hỗ trợ
  const updateSort = (key) => {
    if (sortBy.value === key) {
      toggleSortOrder()
    } else {
      sortBy.value = key
      sortOrder.value = 'asc'
    }
  }
  
  const toggleSortOrder = () => {
    sortOrder.value = sortOrder.value === 'asc' ? 'desc' : 'asc'
  }
  
  // Các hàm chỉnh sửa như ở phiên bản trước
  const startEdit = (plane) => {
    editingAircraft.value = {...plane}
  }
  
  const cancelEdit = () => {
    editingAircraft.value = null
  }
  
  const saveAircraft = () => {
    const index = aircraft.findIndex(a => a.id === editingAircraft.value.id)
    if (index !== -1) {
      aircraft[index] = {...editingAircraft.value}
    }
    editingAircraft.value = null
  }
  </script>