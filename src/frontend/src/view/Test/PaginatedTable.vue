<template>
    <div class="container mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">Danh sách người dùng</h1>
      
      <!-- Bảng danh sách -->
      <div class="overflow-x-auto">
        <table class="w-full bg-white shadow-md rounded-lg">
          <thead>
            <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
              <th class="py-3 px-6 text-left">ID</th>
              <th class="py-3 px-6 text-left">Tên</th>
              <th class="py-3 px-6 text-left">Email</th>
            </tr>
          </thead>
          <tbody class="text-gray-600 text-sm font-light">
            <tr 
              v-for="user in paginatedUsers" 
              :key="user.id" 
              class="border-b border-gray-200 hover:bg-gray-100"
            >
              <td class="py-3 px-6">{{ user.id }}</td>
              <td class="py-3 px-6">{{ user.name }}</td>
              <td class="py-3 px-6">{{ user.email }}</td>
            </tr>
          </tbody>
        </table>
      </div>
  
      <!-- Phân trang -->
      <div class="flex justify-center items-center mt-4 space-x-2">
        <button 
          @click="prevPage" 
          :disabled="currentPage === 1"
          class="px-4 py-2 bg-blue-500 text-white rounded 
                 disabled:bg-gray-300 disabled:cursor-not-allowed 
                 hover:bg-blue-600 transition duration-300"
        >
          Trước
        </button>
  
        <div class="flex space-x-2">
          <button 
            v-for="pageNumber in pageNumbers" 
            :key="pageNumber"
            @click="currentPage = pageNumber"
            :class="[
              'w-10 h-10 rounded',
              currentPage === pageNumber 
                ? 'bg-blue-500 text-white' 
                : 'bg-gray-200 text-gray-700 hover:bg-blue-100'
            ]"
          >
            {{ pageNumber }}
          </button>
        </div>
  
        <button 
          @click="nextPage" 
          :disabled="currentPage === totalPages"
          class="px-4 py-2 bg-blue-500 text-white rounded 
                 disabled:bg-gray-300 disabled:cursor-not-allowed 
                 hover:bg-blue-600 transition duration-300"
        >
          Tiếp
        </button>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, computed } from 'vue'
  
  // Dữ liệu mẫu
  const users = ref([
    { id: 1, name: 'Nguyễn Văn A', email: 'nva@example.com' },
    { id: 2, name: 'Trần Thị B', email: 'ttb@example.com' },
    { id: 3, name: 'Lê Văn C', email: 'lvc@example.com' },
    { id: 4, name: 'Phạm Thị D', email: 'ptd@example.com' },
    { id: 5, name: 'Hoàng Văn E', email: 'hve@example.com' },
    { id: 6, name: 'Vũ Thị F', email: 'vtf@example.com' },
    { id: 7, name: 'Đỗ Văn G', email: 'dvg@example.com' },
    { id: 8, name: 'Ngô Thị H', email: 'nth@example.com' },
    { id: 9, name: 'Trương Văn I', email: 'tvi@example.com' },
    { id: 10, name: 'Cao Thị J', email: 'ctj@example.com' },
    { id: 11, name: 'Đinh Văn K', email: 'dvk@example.com' },
    { id: 12, name: 'Bùi Thị L', email: 'btl@example.com' }
  ])
  
  // Cấu hình phân trang
  const currentPage = ref(1)
  const itemsPerPage = ref(5)
  
  // Tính toán các giá trị phân trang
  const totalPages = computed(() => Math.ceil(users.value.length / itemsPerPage.value))
  
  const pageNumbers = computed(() => {
    const range = []
    for (let i = 1; i <= totalPages.value; i++) {
      range.push(i)
    }
    return range
  })
  
  // Danh sách người dùng sau khi phân trang
  const paginatedUsers = computed(() => {
    const start = (currentPage.value - 1) * itemsPerPage.value
    const end = start + itemsPerPage.value
    return users.value.slice(start, end)
  })
  
  // Các hàm điều hướng trang
  const nextPage = () => {
    if (currentPage.value < totalPages.value) {
      currentPage.value++
    }
  }
  
  const prevPage = () => {
    if (currentPage.value > 1) {
      currentPage.value--
    }
  }
  </script>