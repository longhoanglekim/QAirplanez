<template>
  <div class="min-h-screen bg-gray-100 p-8">
    <div class="max-w-4xl mx-auto bg-white shadow-md rounded-lg p-6">
      <h1 class="text-2xl font-bold text-gray-800 mb-4">Chức năng cho khách hàng</h1>
      <ul class="list-disc pl-6 text-gray-700 space-y-2">
        <li>
          Xem thông tin chung và thông tin về các chuyến bay.
        </li>
        <li>
          Tìm chuyến bay.
        </li>
        <li>
          Đặt vé (không yêu cầu tích hợp thanh toán online).
        </li>
        <li>
          Hủy vé trong thời gian còn hạn được hủy.
        </li>
        <li>
          Theo dõi thông tin về các chuyến bay đã đặt.
        </li>
      </ul>
      <div class="mt-6">
        <button
          class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600"
          @click="bookFlight"
        >
          Đặt vé ngay
        </button>
        <button
          class="bg-red-500 text-white px-4 py-2 rounded ml-4 hover:bg-red-600"
          @click="cancelFlight"
        >
          Hủy vé
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  methods: {
    bookFlight() {
      alert("Chức năng đặt vé đang được phát triển!");
    },
    cancelFlight() {
      alert("Chức năng hủy vé đang được phát triển!");
    },
  },
};
</script>

<style>
/* Thêm bất kỳ cấu hình CSS tùy chỉnh nếu cần */
</style>
