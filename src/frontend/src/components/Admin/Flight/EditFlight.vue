<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 ">
    <div class="bg-white p-6 rounded-lg w-1/2">
      <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Chuyến Bay</h3>
      <div class="space-y-4">
        <div class="flex flex-col">
          <label class="mb-1">Mã Chuyến Bay</label>
          <input
              v-model="flightData.flightNumber"
              placeholder="Mã Chuyến Bay"
              class="w-full p-2 border rounded"
              readonly
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Điểm Đi</label>
          <input
              v-model="flightData.departureCode"
              placeholder="Điểm Đi"
              class="w-full p-2 border rounded"
              readonly
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Điểm Đến</label>
          <input
              v-model="flightData.arrivalCode"
              placeholder="Điểm Đến"
              class="w-full p-2 border rounded"
              readonly
          />
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Máy Bay</label>
          <select v-model="flightData.serialNumber" class="w-full p-2 border rounded">
            <option v-for="aircraft in aircrafts" :key="aircraft.serialNumber" 
            :value="aircraft.serialNumber">{{ aircraft.serialNumber }}</option>
          </select>
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
          <label class="mb-1">Thời Gian Đến (dự kiến)</label>
          <input
              v-model="flightData.expectedArrivalTime"
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
            <option value="On-time">On-time</option>
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
import { ref, defineEmits, defineProps, watch ,} from 'vue'
import { useFlightStore } from '@/store/flightstore'
import { useAircraftStore } from '@/store/aircraftstore'

const emit = defineEmits(['close', 'update-flight'])
const props = defineProps({
  flight: {
    type: Object,
    required: true
  }
})

const storeFlight = useFlightStore()
const storeAircraft = useAircraftStore()

const aircrafts = ref(storeAircraft.getActiveAircraft())

const flightData = ref({
  flightNumber: props.flight.flightNumber,
  departureCode: props.flight.departureCode,
  arrivalCode: props.flight.arrivalCode,
  serialNumber: props.flight.serialNumber,
  expectedDepartureTime: props.flight.expectedDepartureTime,
  expectedArrivalTime: props.flight.expectedArrivalTime,
  status: props.flight.status,
})

// Watch for status changes to reset delayHours when not delayed
watch(() => flightData.value.status, (newStatus) => {
  if (newStatus !== 'Delayed') {
    flightData.value.delayHours = 0
  }
})

const closeModal = () => {
  emit('close')
  resetForm()
}

const saveFlight = async () => {
  try {
    // Ensure delayHours is included in the payload only when status is Delayed
    const payload = { ...flightData.value }

    const result = await storeFlight.editFlight(payload)
    if (result.success) {
      emit('update-flight')
      closeModal()
    } else {
      alert(result.message)
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
    status: 'Scheduled',
    delayHours: 0
  }
}
</script>

<style scoped>
</style>