<!-- TicketCard.vue -->
<template>
  <div class="ticket-card">
    <div class="ticket-info">
      <p><strong>Departure:</strong> {{ departure.cityCode }} - {{ departure.time }}</p>
      <p><strong>Arrival:</strong> {{ arrival.cityCode }} - {{ arrival.time }}</p>
    </div>

    <!-- Chọn loại vé -->
    <div class="ticket-class-selection">
      <button 
        :class="{ active: selectedClass === 'economy' }"
        @click="selectTicketClass('economy')">Vé Phổ Thông</button>
      <button 
        :class="{ active: selectedClass === 'business' }"
        @click="selectTicketClass('business')">Vé Hạng Thương Gia</button>
    </div>

    <div v-if="selectedClass" class="baggage-info">
      <h3>Thông tin hành lý cho vé {{ selectedClass === 'economy' ? 'Phổ Thông' : 'Hạng Thương Gia' }}</h3>
      <table>
        <thead>
          <tr>
            <th>Loại hành lý</th>
            <th>Thông tin</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Hành lý xách tay</td>
            <td>{{ baggageInfo[selectedClass].handBaggage }}</td>
          </tr>
          <tr>
            <td>Hành lý ký gửi</td>
            <td>{{ baggageInfo[selectedClass].checkedBaggage }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    departure: {
      type: Object,
      required: true,
      validator(value) {
        // Sử dụng Object.prototype.hasOwnProperty.call() để tránh lỗi ESLint
        return Object.prototype.hasOwnProperty.call(value, 'time') && Object.prototype.hasOwnProperty.call(value, 'cityCode');
      }
    },
    arrival: {
      type: Object,
      required: true,
      validator(value) {
        // Sử dụng Object.prototype.hasOwnProperty.call() để tránh lỗi ESLint
        return Object.prototype.hasOwnProperty.call(value, 'time') && Object.prototype.hasOwnProperty.call(value, 'cityCode');
      }
    }
  },
  data() {
    return {
      selectedClass: '', // Lưu loại vé đã chọn
      baggageInfo: {
        economy: {
          handBaggage: '1 xách tay tối đa 7kg',
          checkedBaggage: '20kg'
        },
        business: {
          handBaggage: '2 xách tay tối đa 12kg',
          checkedBaggage: '40kg'
        }
      }
    };
  },
  methods: {
    selectTicketClass(classType) {
      if (this.selectedClass != classType) this.selectedClass = classType;
      else this.selectedClass = '';
    }
  }
};
</script>

<style scoped>
.ticket-card {
  border: 1px solid #ccc;
  padding: 15px;
  margin: 10px 0;
  border-radius: 8px;
}

.ticket-info {
  font-size: 14px;
}

.ticket-class-selection {
  margin-top: 15px;
}

.ticket-class-selection button {
  padding: 8px 15px;
  margin: 5px;
  background-color: #f0f0f0;
  border: 1px solid #ccc;
  cursor: pointer;
}

.ticket-class-selection button.active {
  background-color: #007bff;
  color: white;
}

.baggage-info {
  margin-top: 20px;
  padding: 10px;
  border: 1px solid #eee;
}

.baggage-info table {
  width: 100%;
  border-collapse: collapse;
}

.baggage-info th, .baggage-info td {
  padding: 8px;
  border: 1px solid #ddd;
}

.baggage-info th {
  background-color: #f7f7f7;
}
</style>
