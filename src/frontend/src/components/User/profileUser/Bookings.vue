<script>
export default {
  name: "MyBookings",
  data() {
    return {
      bookings: [
        {
          id: 1,
          bookingId: "#1111111",
          bookingFrom: "Việt Nam",
          bookingTo: "Nhật Bản",
          bookingAmount: "$10",
          type: "Một chiều",
          dateGo: "2024-12-02 14:30",
          dateReturn: null,
          status: "Hoàn thành",
        },
        {
          id: 2,
          bookingId: "#2222222",
          bookingFrom: "Mỹ",
          bookingTo: "Canada",
          bookingAmount: "$20",
          type: "Khứ hồi",
          dateGo: "2024-12-03 10:15",
          dateReturn: "2024-12-10 18:45",
          status: "Đã hủy",
        },
      ],
      currentPage: 1,
      itemsPerPage: 10,
    };
  },
  computed: {
    totalBookings() {
      return this.bookings.length;
    },
    totalPages() {
      return Math.ceil(this.bookings.length / this.itemsPerPage);
    },
    paginatedBookings() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      return this.bookings.slice(start, start + this.itemsPerPage);
    },
    startIndex() {
      return (this.currentPage - 1) * this.itemsPerPage;
    },
  },
  methods: {
    prevPage() {
      if (this.currentPage > 1) this.currentPage--;
    },
    nextPage() {
      if (this.currentPage < this.totalPages) this.currentPage++;
    },
    setPage(page) {
      this.currentPage = page;
    },
  },
};
</script>

<template>
  <h1>My Bookings</h1>
  <div class="bookings-container">
    <h2>Recent Bookings <span class="total-bookings">(Total {{ totalBookings }} Bookings)</span></h2>
    <table class="bookings-table">
      <thead>
      <tr>
        <th>Sl. no.</th>
        <th>ID</th>
        <th>Điểm đi</th>
        <th>Điểm đến</th>
        <th>Giá vé</th>
        <th>Loại vé</th>
        <th>Ngày đi</th>
        <th>Ngày về</th>
        <th>Trạng thái</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="(booking, index) in paginatedBookings" :key="booking.id">
        <td>{{ startIndex + index + 1 }}</td>
        <td>{{ booking.bookingId }}</td>
        <td>{{ booking.bookingFrom }}</td>
        <td>{{ booking.bookingTo }}</td>
        <td>{{ booking.bookingAmount }}</td>
        <td>{{ booking.type }}</td>
        <td>{{ booking.dateGo }}</td>
        <td>{{ booking.dateReturn}}</td>
        <td :class="{ confirmed: booking.status === 'Hoàn thành', canceled: booking.status === 'Đã hủy' }">
          {{ booking.status }}
        </td>
      </tr>
      </tbody>
    </table>

    <div class="pagination">
      <button :disabled="currentPage === 1" @click="prevPage">&lt;</button>
      <button
          v-for="page in totalPages"
          :key="page"
          :class="{ active: currentPage === page }"
          @click="setPage(page)"
      >
        {{ page }}
      </button>
      <button :disabled="currentPage === totalPages" @click="nextPage">&gt;</button>
    </div>
  </div>
</template>


<style scoped>
.bookings-container {
  max-width: 1000px;
  margin: auto;
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
  font-family: Arial, sans-serif;
}

h2 {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.total-bookings {
  font-size: 0.8rem;
  color: #888;
}

.bookings-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
}

.bookings-table th,
.bookings-table td {
  border: 1px solid #ddd;
  padding: 8px;
  text-align: left;
}

.bookings-table th {
  background: #f5f5f5;
  font-weight: bold;
}

.bookings-table tbody tr:nth-child(even) {
  background: #f9f9f9;
}

.bookings-table .confirmed {
  color: green;
  font-weight: bold;
}

.bookings-table .canceled {
  color: red;
  font-weight: bold;
}

.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.pagination button {
  border: 1px solid #ddd;
  padding: 5px 10px;
  margin: 0 2px;
  background: #fff;
  cursor: pointer;
  border-radius: 4px;
}

.pagination button.active {
  background: #007bff;
  color: #fff;
  font-weight: bold;
}

.pagination button:disabled {
  cursor: not-allowed;
  background: #f5f5f5;
}
</style>
