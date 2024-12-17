<template>
  <div>
    <h2 class="text-xl font-bold mb-4">Quản Lý Chuyến Bay</h2>

    <!-- Modal chỉnh sửa chuyến bay -->
    <div v-if="editingFlight" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div class="bg-white p-6 rounded-lg w-1/2">
        <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Chuyến Bay</h3>
        <div class="space-y-4">
          <input
              v-model="editingFlight.flightNumber"
              placeholder="Mã Chuyến Bay"
              class="w-full p-2 border rounded"
          />
          <input
              v-model="editingFlight.departureCode"
              placeholder="Điểm Đi"
              class="w-full p-2 border rounded"
          />
          <input
              v-model="editingFlight.arrivalCode"
              placeholder="Điểm Đến"
              class="w-full p-2 border rounded"
          />
          <input
              v-model="editingFlight.aircraftCode"
              placeholder="Máy Bay"
              class="w-full p-2 border rounded"
          />
          <input
              v-model="editingFlight.expectedDepartureTime"
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
      <tr v-for="flight in flights" :key="flight.flightNumber">
        <td class="border p-2">{{ flight.flightNumber }}</td>
        <td class="border p-2">{{ flight.departureCode }}</td>
        <td class="border p-2">{{ flight. arrivalCode }}</td>
        <td class="border p-2">{{ flight.aircraftCode }}</td>
        <td class="border p-2">{{ formatDateTime(flight.expectedDepartureTime) }}</td>
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