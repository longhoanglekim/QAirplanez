<template>
    <div>This is booking</div>
    <div class="flight-booking-form">
        <form action="" @submit.prevent="submitForm">
          <div class="form-row">
            <button @click=changeKhuHoi(true) id="kh">Khu hoi</button>
            <button @click="changeKhuHoi(false)">Mot chieu</button>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label for="flightFrom">Điểm đi:</label>
              <select id="flightFrom" v-model="form.departure">
                  <option value="">Chọn chuyến bay</option>
                  <option value="SG">TP.HCM</option>
                  <option value="HN">Hà Nội</option>
                  <option value="DN">Đà Nẵng</option>
              </select>
            </div>
            <div class="form-group">
              <label for="flightTo">Điểm tới:</label>
              <select id="flightTo" v-model="form.arrival">
                  <option value="">Chọn chuyến bay</option>
                  <option value="SG">TP.HCM</option>
                  <option value="HN">Hà Nội</option>
                  <option value="DN">Đà Nẵng</option>
              </select>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label for="departureDate">Ngày đi:</label>
              <input type="date" id="departureDate" v-model="form.departureDate"  />
            </div>
            <div class="form-group" v-if="laKhuHoi">
              <label for="departureDate">Ngày về:</label>
              <input type="date" id="departureDate" v-model="form.returnDate"  />
            </div>
          </div>
            
          <div class="form-row">
            <div class="form-group">
                <input type="text" name="" id="chonHanhKhach">
                <label for="chonHanhKhach">Hanh khach</label>
                <input type="hidden" name="nguoiLon" id="soNguoiLon"><input type="hidden" name="treEm" id="soTreEm">
                <ul>
                  <li>
                    <div>
                      <p>Nguoi lon</p>
                      <button @click="tangNguoiLon">+</button>
                      <span>{{ form.soNguoiLon }}</span>
                      <button @click="giamNguoiLon">-</button>
                    </div>
                  </li>
                  <li>
                    <div>
                      <p>Tre em</p>
                      <button v-on:click="tangTreEm">+</button>
                      <span>{{ form.soTreEm }}</span>
                      <button v-on:click="giamTreEm">-</button>
                    </div>
                  </li>
                </ul>
            </div>
          </div>
          <div>
            <button type="submit" @click="submitForm">Đăng ký chuyến bay</button>
          </div>
            
        </form>
    </div>
</template>
<script scoped>
export default {
    name: 'FlightSearch',
    data() {
    return {
      form: {
        departure:'',
        arrival:'',
        departureDate: '',
        returnDate:'',
        ticketType:'',
        soNguoiLon: 0,
          soTreEm:0
        },
      submitted: false,
      laKhuHoi:true
    };
  },
  methods: {
    async sendRequestToServer() {
      console.log(this.form);
    },
    changeKhuHoi(i) {
      if (i == true) this.laKhuHoi = true;
      else this.laKhuHoi = false;
    },
    async submitForm() {
      this.submitted = true;
      console.log('Form submitted:', this.form);
      this.$route.push('/booking/avaibility/0');
    },
    tangNguoiLon() {
      if(this.form.soNguoiLon < 10) this.form.soNguoiLon++;
    }, 
    giamNguoiLon() {
      if(this.form.soNguoiLon > 0) this.form.soNguoiLon--;
    },
    tangTreEm() {
      if (this.form.soTreEm < this.form.soNguoiLon) this.form.soTreEm++;
    },
    giamTreEm() {
      if (this.form.soTreEm > 0) this.form.soTreEm--;
    }
  }
}
</script>

<style scoped>
.flight-booking-form {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-row {
  display: flex;
}

.form-group {
  display: block;
  margin-bottom: 15px;
}

label {
  font-weight: bold;
  display: block;
  margin-bottom: 5px;
}

input:not([type="radio"]),
select {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

button {
  padding: 10px 15px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}

.confirmation-message {
  margin-top: 20px;
  padding: 15px;
  background-color: #e9f7ef;
  border: 1px solid #d4edda;
  border-radius: 4px;
}

.confirmation-message h3 {
  margin-top: 0;
}
</style>