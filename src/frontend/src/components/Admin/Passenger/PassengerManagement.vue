<template>
    <div>
      <h2 class="text-xl font-bold mb-4">Quản Lý Hành Khách</h2>
      <table class="w-full border">
        <thead>
          <tr>
            <th class="border p-2">Mã Hành Khách</th>
            <th class="border p-2">Tên</th>
            <th class="border p-2">Chuyến Bay</th>
            <th class="border p-2">Ghế Ngồi</th>
            <th class="border p-2">Hạng Vé</th>
            <th class="border p-2">Hành Động</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="passenger in passengers" :key="passenger.bookingCode">
            <td class="border p-2">{{ passenger.bookingCode }}</td>
            <td class="border p-2">{{ passenger.fullName }}</td>
            <td class="border p-2">{{ passenger.flightNumber }}</td>
            <td class="border p-2">{{ passenger.seatCode }}</td>
            <td class="border p-2">{{ passenger.outboundSeatCode}}</td>
            <td class="border p-2">{{ passenger.outboundTicketClassCode}}</td>
            <td class="border p-2">
              <button class="bg-blue-500 text-white p-1 rounded">Chỉnh Sửa</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script setup>
  import { passengers } from '@/assets/data'
  </script>