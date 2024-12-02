<template>
    <div class="max-w-4xl mx-auto p-6 bg-white shadow-lg rounded-lg">
      <div class="flex justify-between items-center">
        <div>
          <h1 class="text-xl font-semibold">HAN</h1>
          <p class="text-sm text-gray-500">00:25</p>
        </div>
        <div class="flex items-center space-x-4">
          <div class="text-gray-500 text-sm">18 hrs 30 mins</div>
          <div class="text-gray-500 text-sm">1 connection</div>
        </div>
        <div>
          <h1 class="text-xl font-semibold">HAM</h1>
          <p class="text-sm text-gray-500">12:55</p>
        </div>
      </div>
      <div class="grid grid-cols-3 mt-6">
        <!-- Hạng Kinh Tế -->
        <div class="border rounded-lg p-4 text-center">
          <h2 class="text-lg font-semibold text-green-600">Economy</h2>
          <p class="text-sm text-gray-500">from VND</p>
          <p class="text-2xl font-bold">22,938,000</p>
          <p class="text-sm text-green-600">Lowest price</p>
        </div>
        <!-- Hạng Thương Gia -->
        <div class="border rounded-lg p-4 text-center">
          <h2 class="text-lg font-semibold text-blue-600">Business</h2>
          <p class="text-sm text-gray-500">from VND</p>
          <p class="text-2xl font-bold">120,410,000</p>
        </div>
        <!-- Hạng Nhất -->
        <div class="border rounded-lg p-4 text-center">
          <h2 class="text-lg font-semibold text-red-600">First</h2>
          <p class="text-sm text-gray-500">from VND</p>
          <p class="text-2xl font-bold">185,188,000</p>
          <p class="text-sm text-gray-500 italic">Partially available</p>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: "FlightCard",
  };
  </script>
  
  <style>
  /* Bạn có thể thêm các style tùy chỉnh tại đây nếu cần */
  </style>
  