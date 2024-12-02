<template>
  <div @click="console.log('isdashboard')" class="grid grid-cols-2 gap-4">
    <div class= "bg-blue-100 p-4 rounded mx-4">
      <h3 class="font-bold">Máy Bay</h3>
      <p>Tổng số: {{ aircraft.length }}</p>
      <p>Đang hoạt động: {{ activeAircraft }}</p>
    </div>
    <div class="bg-green-100 p-4 rounded">
      <h3 class="font-bold">Chuyến Bay</h3>
      <p>Tổng số: {{ flights.length }}</p>
      <p>Đang lên lịch: {{ scheduledFlights }}</p>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { aircraft, flights } from '@/assets/data'

const activeAircraft = computed(() => 
  aircraft.filter(a => a.status === 'Active').length
)

const scheduledFlights = computed(() => 
  flights.filter(f => f.status === 'Scheduled').length
)

</script>

<style scoped>
</style>