<!-- FlightSearchForm.vue -->
<template>
  <div class="flight-search-form">
    <h2>Tìm Vé Máy Bay</h2>
    <button @click="toSearch">to search</button>

    <form @submit.prevent="submitForm">
      <!-- Loại vé -->
      <div class="form-group">
        <label for="ticketType">Loại vé</label>
        <select v-model="form.ticketType" id="ticketType" required>
          <option value="one-way">Một chiều</option>
          <option value="round-trip">Khứ hồi</option>
        </select>
      </div>

      <!-- Điểm đi -->
      <div class="form-group">
        <label for="fromCity">Điểm đi</label>
        <input type="text" v-model="form.fromCity" id="fromCity" required placeholder="Nhập điểm đi">
      </div>

      <!-- Điểm đến -->
      <div class="form-group">
        <label for="toCity">Điểm đến</label>
        <input type="text" v-model="form.toCity" id="toCity" required placeholder="Nhập điểm đến">
      </div>

      <!-- Ngày đi -->
      <div class="form-group">
        <label for="departureDate">Ngày đi</label>
        <input type="date" v-model="form.departureDate" id="departureDate" required />
      </div>

      <!-- Ngày về (chỉ hiển thị khi chọn vé khứ hồi) -->
      <div v-if="form.ticketType === 'round-trip'" class="form-group">
        <label for="returnDate">Ngày về</label>
        <input type="date" v-model="form.returnDate" id="returnDate" required />
      </div>

      <!-- Số vé người lớn -->
      <div class="form-group">
        <label for="adults">Số vé người lớn</label>
        <input type="number" v-model="form.adults" id="adults" min="1" required />
      </div>

      <!-- Số vé trẻ em -->
      <div class="form-group">
        <label for="children">Số vé trẻ em</label>
        <input type="number" v-model="form.children" id="children" :max="form.adults" min="0" required />
      </div>

      <!-- Thông báo lỗi -->
      <div v-if="error" class="error-message">
        <p>{{ error }}</p>
      </div>

      <!-- Nút tìm kiếm -->
      <div class="form-group">
        <button type="submit" :disabled="isSubmitDisabled">Tìm kiếm</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      form: {
        ticketType: 'round-trip', // Loại vé (1 chiều hoặc khứ hồi)
        fromCity: '',          // Điểm đi
        toCity: '',            // Điểm đến
        departureDate: '',     // Ngày đi
        returnDate: '',        // Ngày về (chỉ khi chọn vé khứ hồi)
        adults: 1,             // Số vé người lớn
        children: 0            // Số vé trẻ em
      },
      error: ''
    };
  },
  computed: {
    isSubmitDisabled() {
      // Kiểm tra các điều kiện để vô hiệu hóa nút tìm kiếm
      return this.form.adults <= 0 || this.form.children >= this.form.adults || !this.form.fromCity || !this.form.toCity || !this.form.departureDate || (this.form.ticketType === 'round-trip' && !this.form.returnDate);
    }
  },
  methods: {

    toSearch() {
      // Chuyển hướng sang trang kết quả tìm kiếm và truyền các tham số tìm kiếm qua URL
      this.$router.push('/booking/avaibility/0');
    },
    submitForm() {
      // Kiểm tra và xử lý dữ liệu form khi người dùng nhấn nút tìm kiếm
      if (this.form.adults <= 0) {
        this.error = 'Số vé người lớn phải lớn hơn 0.';
        return;
      }
      if (this.form.children >= this.form.adults) {
        this.error = 'Số vé trẻ em phải nhỏ hơn số vé người lớn.';
        return;
      }
      if (!this.form.fromCity || !this.form.toCity) {
        this.error = 'Điểm đi và điểm đến không thể để trống.';
        return;
      }
      if (!this.form.departureDate) {
        this.error = 'Ngày đi không thể để trống.';
        return;
      }
      if (this.form.ticketType === 'round-trip' && !this.form.returnDate) {
        this.error = 'Ngày về không thể để trống khi chọn vé khứ hồi.';
        return;
      }

      this.error = ''; // Reset lỗi nếu tất cả điều kiện hợp lệ

      // Ở đây, bạn có thể gọi API hoặc thực hiện thao tác tìm kiếm vé
      console.log('Tìm vé máy bay với các thông tin:', this.form);
      // Gửi thông tin tìm vé đến server hoặc xử lý logic tiếp theo ở đây
      this.toSearch();
    }
  }
};
</script>

<style scoped>
.flight-search-form {
  max-width: 500px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
}

h2 {
  text-align: center;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 15px;
}

label {
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
}

input[type="text"], input[type="date"], select, input[type="number"] {
  width: 100%;
  padding: 8px;
  margin-top: 5px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  width: 100%;
  padding: 10px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:disabled {
  background-color: #cccccc;
  cursor: not-allowed;
}

.error-message {
  color: red;
  margin-top: 15px;
}
</style>
