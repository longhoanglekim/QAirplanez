<template>
  <div class="flex justify-between items-center bg-gray-100 p-4 rounded-b-lg">
    <div class="flex items-center space-x-2">
      <icon-clock class="text-blue-600" />
      <div>
        <p class="text-sm text-gray-700">Departure</p>
        <p class="font-semibold">{{ departureTime }}</p>
      </div>
    </div>
    
    <div class="flex items-center space-x-2">
      <icon-clock class="text-green-600" />
      <div>
        <p class="text-sm text-gray-700">Arrival</p>
        <p class="font-semibold">{{ arrivalTime }}</p>
      </div>
    </div>
    
    <div class="flex items-center space-x-2">
      <icon-dollar class="text-purple-600" />
      <div>
        <p class="text-sm text-gray-700">Price</p>
        <p class="font-bold text-lg">{{ price }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    departureTime: {
      type: String,
      required: true
    },
    arrivalTime: {
      type: String, 
      required: true
    },
    price: {
      type: String,
      required: true
    }
  }
}
</script>