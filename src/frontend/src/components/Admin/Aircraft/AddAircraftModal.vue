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
              :class="{ 'border-red-500': errors.manufacturer }"
          />
          <span v-if="errors.manufacturer" class="text-red-500 text-sm mt-1">{{ errors.manufacturer }}</span>
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Model</label>
          <input
              v-model="aircraftData.model"
              placeholder="Model máy bay"
              class="w-full p-2 border rounded"
              :class="{ 'border-red-500': errors.model }"
          />
          <span v-if="errors.model" class="text-red-500 text-sm mt-1">{{ errors.model }}</span>
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Số ghế</label>
          <input
              v-model.number="aircraftData.numberOfSeats"
              type="number"
              placeholder="Số ghế"
              class="w-full p-2 border rounded"
              :class="{ 'border-red-500': errors.numberOfSeats }"
              min="1"
          />
          <span v-if="errors.numberOfSeats" class="text-red-500 text-sm mt-1">{{ errors.numberOfSeats }}</span>
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Trạng thái</label>
          <select v-model="aircraftData.status" class="w-full p-2 border rounded">
            <option value="Active">Đang rảnh</option>
            <option value="Inactive">Đang sửa chữa</option>
          </select>
        </div>
        <div v-if="errorMessage" class="text-red-500 text-sm mt-1">{{ errorMessage }}</div>
        <div class="flex justify-end space-x-2">
          <button @click="closeModal" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
          <button @click="addAircraft" class="bg-blue-500 text-white p-2 rounded">Thêm</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref , defineEmits, onMounted} from 'vue'
import { useAircraftStore } from '@/store/aircraftstore'

const storeAircraft = useAircraftStore()
const emit = defineEmits(['close', 'add-aircraft'])
const errorMessage = ref('')
const aircraftData = ref({
  manufacturer: '',
  model: '',
  numberOfSeats: 0,
  status: 'Active'
})

const errors = ref({
  manufacturer: '',
  model: '',
  numberOfSeats: ''
})

const closeModal = () => {
  emit('close')
  resetForm()
}

const validateForm = () => {
  let isValid = true
  errors.value = {
    manufacturer: '',
    model: '',
    numberOfSeats: ''
  }

  if (!aircraftData.value.manufacturer.trim()) {
    errors.value.manufacturer = 'Vui lòng nhập nhà sản xuất'
    isValid = false
  }

  if (!aircraftData.value.model.trim()) {
    errors.value.model = 'Vui lòng nhập model máy bay'
    isValid = false
  }

  if (!aircraftData.value.numberOfSeats || aircraftData.value.numberOfSeats <= 0) {
    errors.value.numberOfSeats = 'Số ghế phải lớn hơn 0'
    isValid = false
  }

  return isValid
}

const addAircraft = async () => {
  // Validate form before proceeding
  if (!validateForm()) {
    return;
  }

  try {
    const result = await storeAircraft.addAircraft(aircraftData.value);
    
    // Check for successful result
    if (result.success) {
      alert('Thêm máy bay thành công')
      // Emit event to parent component
      emit('add-aircraft');
      
      // Close modal after successful addition
      closeModal();
    } else {
      // Set error message from the result
      errorMessage.value = result.message || 'Failed to add aircraft';
      alert(errorMessage.value)
    }
  } catch (error) {
    // Handle any unexpected errors
    console.error('Error adding aircraft:', error);
    errorMessage.value = 'An unexpected error occurred';
  }
};

const resetForm = () => {
  aircraftData.value = {
    manufacturer: '',
    model: '',
    numberOfSeats: 0,
    status: 'Active'
  }
  errorMessage.value = ''
  errors.value = {
    manufacturer: '',
    model: '',
    numberOfSeats: ''
  }
}

onMounted(() => {
  resetForm()
})
</script>