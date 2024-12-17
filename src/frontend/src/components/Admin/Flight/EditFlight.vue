<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white p-6 rounded-lg w-1/2">
      <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Chuyến Bay</h3>
      <div class="space-y-4">
        <div class="flex flex-col">
          <label class="mb-1">Mã Chuyến Bay</label>
          <input
              v-model="flightData.flightNumber"
              placeholder="Mã Chuyến Bay"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Điểm Đi</label>
          <input
              v-model="flightData.departureCode"
              placeholder="Điểm Đi"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Điểm Đến</label>
          <input
              v-model="flightData.arrivalCode"
              placeholder="Điểm Đến"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Máy Bay</label>
          <input
              v-model="flightData.aircraftCode"
              placeholder="Máy Bay"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Thời Gian Khởi Hành</label>
          <input
              v-model="flightData.expectedDepartureTime"
              type="datetime-local"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Trạng Thái</label>
          <select v-model="flightData.status" class="w-full p-2 border rounded">
            <option value="Scheduled">Scheduled</option>
            <option value="Delayed">Delayed</option>
            <option value="Cancelled">Cancelled</option>
            <option value="Completed">Completed</option>
          </select>
        </div>

        <div class="flex justify-end space-x-2">
          <button @click="closeModal" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
          <button @click="saveFlight" class="bg-blue-500 text-white p-2 rounded">Lưu</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineEmits } from 'vue'

const emit = defineEmits(['close', 'update-flight'])

const flightData = ref({
  flightNumber: '',
  departureCode: '',
  arrivalCode: '',
  aircraftCode: '',
  expectedDepartureTime: '',
  status: 'Scheduled'
})

const closeModal = () => {
  emit('close')
  resetForm()
}

const saveFlight = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/flight/admin/updateFlight', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': localStorage.getItem('adminToken'),
        'Accept': 'application/json'
      },
      body: JSON.stringify(flightData.value)
    })

    if (response.ok) {
      emit('update-flight')
      closeModal()
    } else {
      console.error('Failed to update flight')
    }
  } catch (error) {
    console.error('Error updating flight:', error)
  }
}

const resetForm = () => {
  flightData.value = {
    flightNumber: '',
    departureCode: '',
    arrivalCode: '',
    aircraftCode: '',
    expectedDepartureTime: '',
    status: 'Scheduled'
  }
}
</script>

<style scoped>
</style>
