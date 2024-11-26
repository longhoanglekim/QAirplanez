<!-- FlightSearchForm.vue -->
<template>
  <div class="container">
    <div class="button-container">
      <button @click="changeContent('searchFlight')" :class="{chosen: content=='searchFlight'}">Tìm chuyến bay</button>
      <button @click="changeContent('searchTicket')" :class="{chosen: content=='searchTicket'}">Tra cứu vé</button>
    </div>
    <div class="flight-search-form">
      <form @submit.prevent="submitForm" v-if="this.content == 'searchFlight' ">
        <!-- Loại vé -->
        <div class="form-group">
          <label for="ticketType">Loại vé</label>
          <select v-model="form.ticketType" id="ticketType" required>
            <option value="one-way">Một chiều</option>
            <option value="round-trip">Khứ hồi</option>
          </select>
        </div>

        <div class="form-group">
          <label for="fromCity">Điểm đi</label>
          <select
            v-model="form.fromCity"
            id="fromCity"
            required
            placeholder="Điểm đi"
          >
            <option value="">Chọn địa điểm</option>
            <option value="HN">HN</option>
            <option value="SG">SG</option>
            <option value="DN">DN</option>
          </select>
        </div>

        <!-- Điểm đến -->
        <div class="form-group">
          <label for="toCity">Điểm đến</label>
          <select
            v-model="form.toCity"
            id="toCity"
            required
            placeholder="Điểm đi"
          >
            <option value="">Chọn địa điểm</option>
            <option value="HN">HN</option>
            <option value="SG">SG</option>
            <option value="DN">DN</option>
          </select>
        </div>

        <div class="form-group">
          <label for="departureDate">Ngày đi</label>
          <input type="date" v-model="form.departureDate" id="departureDate" required />
        </div>

        <!-- Ngày về (chỉ hiển thị khi chọn vé khứ hồi) -->
        <div  class="form-group">
          <div v-if="form.ticketType === 'round-trip'">
            <label for="returnDate">Ngày về</label>
            <input type="date"  v-model="form.returnDate" id="returnDate" required />
          </div>
        </div>

        <div class="form-group" id="ticketD">
          <label for="ticketDetails">Số vé</label>
          <input 
            type="text" 
            id="ticketDetails" 
            :value="ticketSummary"
            @click="toggleTicketModal" 
            readonly 
            placeholder="Nhấn để chỉnh sửa số vé"
          />
          <div v-if="isModalVisible" class="ticket-modal">
            <div class="modal-content">
              <label for="adults">Số vé người lớn</label>
              <input 
                type="number" 
                id="adults" 
                v-model="form.adults" 
                min="1"
              />
              <label for="children">Số vé trẻ em</label>
              <input 
                type="number" 
                id="children" 
                v-model="form.children" 
                min="0" 
                :max="form.adults"
              />
              <button type="button" @click="closeModal">Xong</button>
            </div>
          </div>
        </div>

        <!-- Thông báo lỗi -->
        <div v-if="error" class="error-message">
          <p>{{ error }}</p>
        </div>

        <!-- Nút tìm kiếm -->
        <div class="form-submit">
          <button class="search" type="submit" :disabled="isSubmitDisabled">Tìm kiếm</button>
        </div>
      </form>
      <form @submit.prevent="submitFormTicket" v-if="this.content == 'searchTicket'">
        <div class="form-group">
          <label for="seatCode">Mã số ngồi</label>
          <input type="text" v-model="form.seatCode" id="seatCode">
        </div>
        <div class="form-group">
          <label for="firstName">Họ</label>
          <input type="text" v-model="form.firstName" id="firstName">
        </div>
        <div v-if="error" class="error-message">
          <p>{{ error }}</p>
        </div>
        <div class="form-submit">
          <button class="search" type="submit" :disabled="isSubmitDisabled">Tìm kiếm</button>
        </div>
      </form>
    </div>
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
      form2: {
        firstName:'',
        seatCode:''
      },
      error: '',
      isModalVisible: false,
      content: ''
    };
  },
  computed: {
    isSubmitDisabled() {
      if (this.content == "searchFlight")
       return this.form.adults <= 0 || this.form.children >= this.form.adults 
      || !this.form.fromCity || !this.form.toCity || !this.form.departureDate 
      || (this.form.ticketType === 'round-trip' && !this.form.returnDate);
      return !this.form2.seatCode || !this.form2.firstName;
    },
    ticketSummary() {
      return `${this.form.adults} người lớn, ${this.form.children} trẻ em`;
    }
  },
  methods: {
    changeContent(newContent) {
      this.content = newContent;
    },
    toggleTicketModal() {
      this.isModalVisible = !this.isModalVisible;
    },
    // Đóng modal khi người dùng xong việc
    closeModal() {
      this.isModalVisible = false;
    },
    toSearch() {
      // Chuyển hướng sang trang kết quả tìm kiếm và truyền các tham số tìm kiếm qua URL
      this.$router.push('/booking/avaibility/0');
    },
    toTicket() {
      this.$router.push('booking/information/0')
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

      console.log('Tìm vé máy bay với các thông tin:', this.form);
      
      this.toSearch();
    },
    submitFormTicket() {
      this.error = '';
      this.toTicket();
    }
  }
};
</script>

<style scoped>
/* Cấu trúc tổng thể */
.container {
  width: 100%;
  max-width: 45rem;
  margin: 0 auto;
  padding-bottom: 1.25rem;
  background-color: #f9f9f9;
  border-radius: 0.5rem; /* 8px = 0.5rem */
  box-shadow: 0 0.25rem 0.75rem rgba(0, 0, 0, 0.1); /* 4px 12px */
}

.button-container {
  display: flex;
  height: 3rem;
  width: 100%;
  background: darkblue;
}

.button-container button {
  flex: 1 1 calc(50%);
  border: none;
}

.chosen {
  background: lightblue;
  outline: none;
  
}

.flight-search-form {
  margin: 1rem;
}

.form-group {
  margin-bottom: 1rem; /* 15px = 1rem */
}

.form-submit {
  display: block;
  width: 100%;
}

form {
  display: flex;
  flex-wrap: wrap;
  gap: 1.25rem; /* 20px = 1.25rem */
}

form > .form-group {
  flex: 1 1 calc(33.33% - 1.5rem); /* Chia đều 3 cột */
  min-width: 12.5rem; /* 200px = 12.5rem */
}

/* Các Label */
label {
  font-size: 0.875rem; /* 14px = 0.875rem */
  color: #555;
  display: block;
  margin-bottom: 0.3125rem; /* 5px = 0.3125rem */
  font-weight: 600;
}

/* Input và Select */
input[type="date"],
input[type="number"],
input[type="text"],
select {
  width: 100%;
  padding: 0.6rem;
  font-size: 1rem; /* 16px = 1rem */
  border: 1px solid #ddd; /* 1px = 0.0625rem */
  border-radius: 0.25rem; /* 4px = 0.25rem */
  box-sizing: border-box;
}


button.search {
  width: 36%;
  padding: 0.75rem; /* 12px = 0.75rem */
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 0.25rem; /* 4px = 0.25rem */
  font-size: 1rem; /* 16px = 1rem */
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button.search:hover {
  background-color: #0056b3;
}

button.search:disabled {
  background-color: #ddd;
  cursor: not-allowed;
}

/* Thông báo lỗi */
.error-message {
  background-color: #ffdddd;
  color: #d8000c;
  padding: 0.6rem; /* 10px = 0.625rem */
  margin-bottom: 1.25rem; /* 20px = 1.25rem */
  border-radius: 0.25rem; /* 4px = 0.25rem */
  font-size: 0.875rem; /* 14px = 0.875rem */
}

#ticketD {
  position: relative;
  
}

#ticketD .ticket-modal {
  position: absolute;
  background: antiquewhite;
  padding: 0.2rem;
}

#ticketD .ticket-modal * {
  margin: 0.2rem;
}

@media (max-width: 768px) {
  /* 768px = 48rem */
  form {
    flex-direction: column;
  }

  .form-group {
    flex: 1 1 100%;
    margin-bottom: 0.3rem;
  }

  .flight-search-form {
    padding: 0.9rem;
    max-width: 70%;
  }
}

@media (max-width: 420px) {
  /* 480px = 30rem */
  .flight-search-form {
    padding: 0.625rem; /* 10px = 0.625rem */
    max-width: 90%;
  }

  h2 {
    font-size: 1.125rem; /* 18px = 1.125rem */
  }
}
</style>
