<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white p-6 rounded-lg w-1/2">
      <h3 class="text-lg font-bold mb-4">Thêm Máy Bay</h3>
      <div class="space-y-4">
        <div class="flex flex-col">
          <label class="mb-1">Nhà sản xuất</label>
          <input
              v-model="aircraftData.manufacturer"
              placeholder="Nhà sản xuất"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Model</label>
          <input
              v-model="aircraftData.model"
              placeholder="Model máy bay"
              class="w-full p-2 border rounded"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Số ghế</label>
          <input
              v-model.number="aircraftData.numberOfSeats"
              type="number"
              placeholder="Số ghế"
              class="w-full p-2 border rounded"
              min="1"
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Trạng thái</label>
          <select v-model="aircraftData.status" class="w-full p-2 border rounded">
            <option value="Active">Đang hoạt động</option>
            <option value="Maintenance">Đang bảo trì</option>
            <option value="Inactive">Không hoạt động</option>
          </select>
        </div>

        <div class="flex justify-end space-x-2">
          <button @click="closeModal" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
          <button @click="addAircraft" class="bg-blue-500 text-white p-2 rounded">Thêm</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref , defineEmits} from 'vue'


const emit = defineEmits(['close', 'add-aircraft'])

const aircraftData = ref({
  manufacturer: '',
  model: '',
  numberOfSeats: 0,
  status: 'Active'
})

const closeModal = () => {
  emit('close')
  resetForm()
}

const addAircraft = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/aircraft/admin/addAircraft', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': localStorage.getItem('token'),
        'Accept': 'application/json'
      },
      body: JSON.stringify(aircraftData.value)
    })

    if (response.ok) {
      emit('add-aircraft')
      closeModal()
    } else {
      console.error('Failed to add aircraft')
    }
  } catch (error) {
    console.error('Error adding aircraft:', error)
  }
}

const resetForm = () => {
  aircraftData.value = {
    manufacturer: '',
    model: '',
    numberOfSeats: 0,
    status: 'Active'
  }
}
</script>