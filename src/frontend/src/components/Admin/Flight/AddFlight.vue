<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white p-6 rounded-lg w-1/2">
      <h3 class="text-lg font-bold mb-4">Thêm Chuyến Bay</h3>
      <div class="space-y-4">
        <div class="flex flex-col">
          <label class="mb-1">Máy Bay</label>
          <select v-model="flightData.serialNumber" class="w-full p-2 border rounded">
            <option v-for="aircraft in activeAircraft" :key="aircraft.serialNumber" 
            :value="aircraft.serialNumber">{{ aircraft.serialNumber }}</option>
          </select>
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Điểm Đi</label>
          <select v-model="flightData.departureCode" class="w-full p-2 border rounded">
            <option v-for="airport in airports" :key="airport.airportCode" :value="airport.airportCode">{{ airport.city }} ({{ airport.airportCode }})</option>
          </select>
        </div>

        <div class="flex flex-col">
          <label class="mb-1">Điểm Đến</label>
          <select v-model="flightData.arrivalCode" class="w-full p-2 border rounded">
            <option v-for="airport in airports" :key="airport.airportCode" :value="airport.airportCode">{{ airport.city }} ({{ airport.airportCode }})</option>
          </select>
        </div>      

        <div class="flex flex-col">
          <label class="mb-1">Thời Gian Khởi Hành (dự kiến)</label>
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
            <option>Scheduled</option>
            <option>Delayed</option>
            <option>Cancelled</option>
            <option>Completed</option>
          </select>
        </div>
        <div v-if="errors" class="p-3 bg-red-100 text-red-700 rounded-md">
          {{ errors }}
        </div>
        <div class="flex justify-end space-x-2">
          <button @click="closeModal" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
          <button @click="addFlight" class="bg-blue-500 text-white p-2 rounded">Thêm</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineEmits,  } from 'vue'
import { useAircraftStore } from '@/store/aircraftstore'
import { useAirportStore } from '@/store/airportstore'
import { useFlightStore } from '@/store/flightstore'

const emit = defineEmits(['close', 'finish-add-flight'])

const storeAircraft = useAircraftStore()
const storeAirport = useAirportStore()
const storeFlight = useFlightStore()
const activeAircraft = ref(storeAircraft.getActiveAircraft())
const airports = ref(storeAirport.getAirports())

const flightData = ref({
  serialNumber: '',
  departureCode: '',
  arrivalCode: '',
  aircraftCode: '',
  expectedDepartureTime: '',
  expectedArrivalTime: '',
  status: 'Scheduled'
})

const errors = ref('')



const validateForm = () => {
  if (!flightData.value.departureCode.trim()) {
    errors.value = 'Vui lòng nhập điểm đi'
    return false
  }
  if (!flightData.value.arrivalCode.trim()) {
    errors.value = 'Vui lòng nhập điểm đến'
    return false
  }
  if (!flightData.value.serialNumber.trim()) {
    errors.value = 'Vui lòng nhập mã máy bay'
    return false
  }
  if (!flightData.value.expectedDepartureTime) {
    errors.value = 'Vui lòng chọn thời gian khởi hành'
    return false
  }
  if (!flightData.value.expectedArrivalTime) {
    errors.value = 'Vui lòng chọn thời gian đến'
    return false
  }
  if (flightData.value.expectedDepartureTime >= flightData.value.expectedArrivalTime) {
    errors.value = 'Thời gian khởi hành phải trước thời gian đến'
    return false
  }
  return true
}

const addFlight = async () => {

  errors.value = ''
  if (!validateForm()) {
    return
  }
  var result = await storeFlight.addFlight(flightData.value)
  if (result.success) {
    emit('finish-add-flight')
    closeModal()
  } else {
    errors.value = result.message
  }
}

const closeModal = () => {
  emit('close')
  resetForm()
}

const resetForm = () => {
  flightData.value = {
    serialNumber: '',
    departureCode: '',
    arrivalCode: '',
    expectedDepartureTime: '',
    expectedArrivalTime: '',
    status: 'Scheduled'
  }
  errors.value = ''
}
</script>
