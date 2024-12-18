<template>
  <div>
    <h2 class="text-xl font-bold mb-4">Quản Lý Chuyến Bay</h2>
    
    <!-- Search Section -->
    <div class="mb-4 flex space-x-2">
      <input 
        v-model="searchCriteria.flightNumber"
        placeholder="Tìm theo Mã Chuyến Bay" 
        class="w-1/4 p-2 border rounded"
      />
      <input 
        v-model="searchCriteria.departureCode"
        placeholder="Tìm theo Điểm Đi" 
        class="w-1/4 p-2 border rounded"
      />
      <input 
        v-model="searchCriteria.arrivalCode"
        placeholder="Tìm theo Điểm Đến" 
        class="w-1/4 p-2 border rounded"
      />
      <select 
        v-model="searchCriteria.status" 
        class="w-1/4 p-2 border rounded"
      >
        <option value="">Tất Cả Trạng Thái</option>
        <option>Scheduled</option>
        <option>Delayed</option>
        <option>Cancelled</option>
        <option>Completed</option>
      </select>
    </div>

    <button @click="openAddModal" class="bg-blue-500 text-white p-2 rounded mb-4">Thêm Chuyến Bay</button>
    
    <AddFlight v-if="isAddModalOpen" @finish-add-flight="finishAddFlight" @close="closeAddModal"/>
    <EditFlight v-if="isEditModalOpen" :flight="editingFlight" @close="closeEditModal"/>
    
    <!-- Modal chỉnh sửa chuyến bay (unchanged from previous version) -->
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
        <tr v-for="flight in filteredFlights" :key="flight.flightNumber">
          <td class="border p-2">{{ flight.flightNumber }}</td>
          <td class="border p-2">{{ flight.departureCode }}</td>
          <td class="border p-2">{{ flight.arrivalCode }}</td>
          <td class="border p-2">{{ flight.serialNumber }}</td>
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
import { onMounted, ref, computed } from 'vue'
import AddFlight from './AddFlight.vue'

import { useAircraftStore } from '@/store/aircraftstore'
import { useAirportStore } from '@/store/airportstore'
import { useFlightStore } from '@/store/flightstore'

const storeAircraft = useAircraftStore()
const storeAirport = useAirportStore()
const storeFlight = useFlightStore()

const flights = ref(storeFlight.getFlights())
const editingFlight = ref(null)
const isAddModalOpen = ref(false)
const isEditModalOpen = ref(false)
// Search criteria
const searchCriteria = ref({
  flightNumber: '',
  departureCode: '',
  arrivalCode: '',
  status: ''
})

// Computed property for filtered flights
const filteredFlights = computed(() => {
  return flights.value.filter(flight => {
    const matchFlightNumber = flight.flightNumber.toLowerCase().includes(searchCriteria.value.flightNumber.toLowerCase())
    const matchDeparture = flight.departureCode.toLowerCase().includes(searchCriteria.value.departureCode.toLowerCase())
    const matchArrival = flight.arrivalCode.toLowerCase().includes(searchCriteria.value.arrivalCode.toLowerCase())
    const matchStatus = !searchCriteria.value.status || flight.status === searchCriteria.value.status

    return matchFlightNumber && matchDeparture && matchArrival && matchStatus
  })
})
  
const startEdit = (flight) => {
  editingFlight.value = {...flight}
}
  
const cancelEdit = () => {
  editingFlight.value = null
}
  
const saveFlight = async () => {
  await refreshFlightData()
}

const openAddModal = () => {
  isAddModalOpen.value = true
}

const closeAddModal = () => {
  isAddModalOpen.value = false
}

const closeEditModal = () => {
  isEditModalOpen.value = false
}
  
const formatDateTime = (dateTime) => {
  return new Date(dateTime).toLocaleString()
}

const finishAddFlight = async () => {
  console.log('finishAddFlight')
   refreshFlightData()
  closeAddModal()
}

const refreshFlightData = async () => {
  await storeFlight.reloadFlights()
  console.log('refreshFlightData')
  flights.value = storeFlight.getFlights()
}

onMounted(async () => {
  await refreshFlightData()
  await storeAirport.reloadAirports()
  await storeAircraft.reloadAircraft()
})
</script>