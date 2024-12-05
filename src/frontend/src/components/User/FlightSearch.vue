<template>
<div class="container w-5/6 md:w-1/2  p-4 rounded-lg place-self-center bg-slate-200 m-4">
    <div class="button-container rounded-full">
        <button @click="changeContent('searchFlight')" class="rounded-full" :class="{chosen: content=='searchFlight'}">Tìm chuyến bay</button>
        <button @click="changeContent('searchTicket')" class="rounded-full" :class="{chosen: content=='searchTicket'}">Tra cứu vé</button>
    </div>
    <div class="flight-search-form">
        <form @submit.prevent="submitForm" v-if="content == 'searchFlight' ">
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
                <select v-model="form.fromCity" id="fromCity" required placeholder="Điểm đi">
                    <option value="">Chọn địa điểm</option>
                    <option value="HAN">HN</option>
                    <option value="SGN">SG</option>
                    <option value="CXR">CXR</option>
                </select>
            </div>

            <!-- Điểm đến -->
            <div class="form-group">
                <label for="toCity">Điểm đến</label>
                <select v-model="form.toCity" id="toCity" required placeholder="Điểm đi">
                    <option value="">Chọn địa điểm</option>
                    <option value="HAN">HN</option>
                    <option value="SGN">SG</option>
                    <option value="CXR">CXR</option>
                </select>
            </div>

            <div class="form-group">
                <label for="departureDate">Ngày đi</label>
                <input type="date" v-model="form.departureDate" id="departureDate" required />
            </div>

            <!-- Ngày về (chỉ hiển thị khi chọn vé khứ hồi) -->
            <div class="form-group">
                <div v-if="form.ticketType === 'round-trip'">
                    <label for="returnDate">Ngày về</label>
                    <input type="date" v-model="form.returnDate" id="returnDate" required />
                </div>
            </div>

            <div class="form-group" id="ticketD">
                <label for="ticketDetails">Số vé (Tối đa 10 vé)</label>
                <input type="text" id="ticketDetails" :value="ticketSummary" @click="toggleTicketModal" readonly placeholder="Nhấn để chỉnh sửa số vé" />
                <div v-if="isModalVisible" class="ticket-modal">
                    <div class="modal-content">
                        <label for="adults">Số vé người lớn</label>
                        <input type="number" id="adults" v-model="form.adults" :min="1 < form.children ? form.children:1" :max="maxAdults"/>
                        <label for="children">Số vé trẻ em</label>
                        <input type="number" id="children" v-model="form.children" min="0" :max="maxChildren" />
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
        <form @submit.prevent="submitFormTicket" v-if="content == 'searchTicket'">
            <div class="form-group">
                <label for="seatCode">Mã số ngồi</label>
                <input type="text" v-model="form2.seatCode" id="seatCode">
            </div>
            <div class="form-group">
                <label for="firstName">Họ</label>
                <input type="text" v-model="form2.firstName" id="firstName">
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

<script setup>
import { ref, computed,defineEmits} from 'vue'
import { searchFlightStore} from '@/store/searchFlight';

const searchFStore = searchFlightStore();

// Reactive state for flight search form
const form = ref({...searchFStore.getOldForm()})

// Reactive state for ticket search form
const form2 = ref({
  firstName: '',
  seatCode: ''
})

const error = ref('')
const isModalVisible = ref(false)
const content = ref('searchFlight')

// Computed properties
const maxAdults = computed(() => 9 - form.value.children)
const maxChildren = computed(() => Math.min(10 - form.value.adults, form.value.adults))

const isSubmitDisabled = computed(() => {
  if (content.value === 'searchFlight') {
    return form.value.adults <= 0 || 
           form.value.children > form.value.adults ||
           form.value.adults + form.value.children > 9 ||
           !form.value.fromCity || 
           !form.value.toCity || 
           !form.value.departureDate ||
           (form.value.ticketType === 'round-trip' && !form.value.returnDate)
  }
  return !form2.value.seatCode || !form2.value.firstName
})

const ticketSummary = computed(() => 
  `${form.value.adults} người lớn, ${form.value.children} trẻ em`
)

// Methods
function changeContent(newContent) {
  if (content.value !== newContent) {
    content.value = newContent
  }
}

function toggleTicketModal() {
  isModalVisible.value = !isModalVisible.value
}

function closeModal() {
  isModalVisible.value = false
}

async function submitForm() {
  // Validation checks
  if (form.value.adults <= 0) {
    error.value = 'Số vé người lớn phải lớn hơn 0.'
    return
  }
  if (form.value.children >= form.value.adults) {
    error.value = 'Số vé trẻ em phải nhỏ hơn số vé người lớn.'
    return
  }
  if (!form.value.fromCity || !form.value.toCity) {
    error.value = 'Điểm đi và điểm đến không thể để trống.'
    return
  }
  if (!form.value.departureDate) {
    error.value = 'Ngày đi không thể để trống.'
    return
  }
  if (form.value.ticketType === 'round-trip' && !form.value.returnDate) {
    error.value = 'Ngày về không thể để trống khi chọn vé khứ hồi.'
    return
  }

  error.value = ''
  searchFStore.saveForm(form.value)

  // Emit event for parent component
  emit('search-flight')
}



function submitFormTicket() {
  error.value = ''
  
  // Emit event for parent component
  emit('search-ticket', form2.value)
}

// Use defineEmits to define emitted events
const emit = defineEmits(['search-flight', 'search-ticket'])
</script>

<style scoped>

.container {
    box-shadow: inset 0 2px 4px 0 rgba(0, 0, 0, 0.271);
}

.button-container {
    display: flex;
    height: 3rem;
    width: 100%;    
}

.button-container button {
    color: white;
    flex: 1 1 calc(50%);
    border: none;
    background: skyblue;
}

.button-container .chosen {
    
    background-color: #007bff;
    opacity: 1;
    outline: none;
}

.flight-search-form {
    margin: 1rem;
}

.form-group {
    margin-bottom: 1rem;
    /* 15px = 1rem */
}

.form-submit {
    display: block;
    width: 100%;
}

form {
    display: flex;
    flex-wrap: wrap;
    gap: 1.25rem;
    /* 20px = 1.25rem */
}

form>.form-group {
    flex: 1 1 calc(33.33% - 1.5rem);
    /* Chia đều 3 cột */
    min-width: 12.5rem;
    /* 200px = 12.5rem */
}

/* Các Label */
label {
    font-size: 0.875rem;
    /* 14px = 0.875rem */
    color: #555;
    display: block;
    margin-bottom: 0.3125rem;
    /* 5px = 0.3125rem */
    font-weight: 600;
}

/* Input và Select */
input[type="date"],
input[type="number"],
input[type="text"],
select {
    width: 100%;
    padding: 0.6rem;
    font-size: 1rem;
    /* 16px = 1rem */
    border: 1px solid #ddd;
    /* 1px = 0.0625rem */
    border-radius: 0.25rem;
    /* 4px = 0.25rem */
    box-sizing: border-box;
}

button.search {
    width: 36%;
    padding: 0.75rem;
    /* 12px = 0.75rem */
    background-color: #007bff;
    color: white;
    border: none;
    border-radius: 0.25rem;
    /* 4px = 0.25rem */
    font-size: 1rem;
    /* 16px = 1rem */
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
    color: #d8000c;
    padding: 0.6rem;
    /* 10px = 0.625rem */
    margin-bottom: 1.25rem;
    /* 20px = 1.25rem */
    border-radius: 0.25rem;
    /* 4px = 0.25rem */
    font-size: 0.875rem;
    /* 14px = 0.875rem */
}

#ticketD {
    position: relative;

}

#ticketD .ticket-modal {
    position: absolute;
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
        padding: 0.625rem;
        /* 10px = 0.625rem */
        max-width: 90%;
    }

    h2 {
        font-size: 1.125rem;
        /* 18px = 1.125rem */
    }
}
</style>
