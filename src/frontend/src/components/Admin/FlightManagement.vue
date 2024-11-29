<template>
    <div>
      <h2 class="text-xl font-bold mb-4">Quản Lý Chuyến Bay</h2>
      
      <!-- Modal chỉnh sửa chuyến bay -->
      <div v-if="editingFlight" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg w-1/2">
          <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Chuyến Bay</h3>
          <div class="space-y-4">
            <input 
              v-model="editingFlight.id" 
              placeholder="Mã Chuyến Bay" 
              class="w-full p-2 border rounded"
            />
            <input 
              v-model="editingFlight.origin" 
              placeholder="Điểm Đi" 
              class="w-full p-2 border rounded"
            />
            <input 
              v-model="editingFlight.destination" 
              placeholder="Điểm Đến" 
              class="w-full p-2 border rounded"
            />
            <input 
              v-model="editingFlight.aircraft" 
              placeholder="Máy Bay" 
              class="w-full p-2 border rounded"
            />
            <input 
              v-model="editingFlight.departureTime" 
              type="datetime-local" 
              class="w-full p-2 border rounded"
            />
            <select 
              v-model="editingFlight.status" 
              class="w-full p-2 border rounded"
            >
              <option>Scheduled</option>
              <option>Delayed</option>
              <option>Cancelled</option>
              <option>Completed</option>
            </select>
            <div class="flex justify-end space-x-2">
              <button 
                @click="cancelEdit" 
                class="bg-gray-500 text-white p-2 rounded"
              >Hủy</button>
              <button 
                @click="saveFlight" 
                class="bg-blue-500 text-white p-2 rounded"
              >Lưu</button>
            </div>
          </div>
        </div>
      </div>
  
      <table class="w-full border">
        <thead>
          <tr>
            <th class="border p-2">Mã Chuyến Bay</th>
            <th class="border p-2">Điểm Đi</th>
            <th class="border p-2">Điểm Đến</th>
            <th class="border p-2">Máy Bay</th>
            <th class="border p-2">Giờ Khởi Hành</th>
            <th class="border p-2">Trạng Thái</th>
            <th class="border p-2">Hành Động</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="flight in flights" :key="flight.id">
            <td class="border p-2">{{ flight.id }}</td>
            <td class="border p-2">{{ flight.origin }}</td>
            <td class="border p-2">{{ flight.destination }}</td>
            <td class="border p-2">{{ flight.aircraft }}</td>
            <td class="border p-2">{{ formatDateTime(flight.departureTime) }}</td>
            <td class="border p-2">{{ flight.status }}</td>
            <td class="border p-2">
              <button 
                @click="startEdit(flight)" 
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
  import { ref } from 'vue'
  import { flights } from '@/assets/data'
  
  const editingFlight = ref(null)
  
  const startEdit = (flight) => {
    editingFlight.value = {...flight}
  }
  
  const cancelEdit = () => {
    editingFlight.value = null
  }
  
  const saveFlight = () => {
    const index = flights.findIndex(f => f.id === editingFlight.value.id)
    if (index !== -1) {
      flights[index] = {...editingFlight.value}
    }
    editingFlight.value = null
  }
  
  const formatDateTime = (dateTime) => {
    return new Date(dateTime).toLocaleString()
  }
  </script>

  <style scoped>
  table {
    width: 100%;
    border-collapse: collapse;
    overflow: hidden;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

th, td {
    margin: 1rem;
}
tr:hover td {
    background-color: rgba(0, 123, 255, 0.05);
}

th {
    background-color: #007bff;
    color: #fff;
}

thead {
    th {
        background-color: #0069d9;
    }
}

tbody {
    tr {
        &:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }
    }
    td {
        position: relative;
        &:hover {
            &:before {
                content: "";
                position: absolute;
                left: 0;
                right: 0;
                top: -9999px;
                bottom: -9999px;
                background-color: rgba(0, 123, 255, 0.1);
                z-index: -1;
            }
        }
    }
}
  </style>