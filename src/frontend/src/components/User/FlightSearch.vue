<template>
<div class="w-5/6 md:w-3/4 xl:w-1/2 rounded-xl shadow-lg place-self-center bg-white m-4 text-left">
    <!-- Tab buttons -->
    <div class="rounded-t-xl bg-gray-50 relative p-4">
        <button @click="changeContent('searchFlight')" 
                class="text-lg w-48 font-medium transition-colors duration-200" 
                :class="{'text-orange-500': content == 'searchFlight', 'text-gray-600': content != 'searchFlight'}">
            Tìm chuyến bay
        </button>
        <button @click="changeContent('searchTicket')" 
                class="text-lg w-48 font-medium transition-colors duration-200" 
                :class="{'text-orange-500': content == 'searchTicket', 'text-gray-600': content != 'searchTicket'}">
            Tra cứu vé
        </button>
        <span class="absolute bottom-0 w-48 border-b-4 border-orange-500 transition-all duration-300"
              :class="{'left-4': content == 'searchFlight', 'left-52': content == 'searchTicket'}">
        </span>
    </div>

    <div class="p-6">
        <form @submit.prevent="submitForm" v-if="content == 'searchFlight'" class="space-y-6">
            <!-- Ticket Type -->
            <div class="flex space-x-4">
                <button type="button" @click="form.ticketType = 'round-trip'" 
                        class="w-32 py-2 rounded-full border-2 transition-all duration-200" 
                        :class="{'bg-orange-500 border-orange-500 text-white': form.ticketType==='round-trip',
                                'border-orange-500 text-orange-500': form.ticketType!=='round-trip'}">
                    Khứ hồi
                </button>
                <button type="button" @click="form.ticketType = 'one-way'" 
                        class="w-32 py-2 rounded-full border-2 transition-all duration-200"
                        :class="{'bg-orange-500 border-orange-500 text-white': form.ticketType==='one-way',
                                'border-orange-500 text-orange-500': form.ticketType!=='one-way'}">
                    Một chiều
                </button>
            </div>

            <!-- From City & Departure Date -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="relative group  p-1">
                    <PlaneTakeoff class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500 group-focus:text-orange-500" />
                    <select v-model="form.fromCity" id="fromCity" 
                            class="w-full h-14 p-3 pt-5 pl-10 rounded-lg border border-gray-300 
                            focus:ring-2 focus:ring-orange-200 focus:border-orange-500 
                            outline-none peer appearance-none"
                            required ref="fromCityRef">
                        <option value="" disabled selected></option>
                        <option v-for="airport in filteredSelectableAirportsFrom" 
                                :key="airport.airportCode" 
                                :value="airport.airportCode">
                            {{airport.city}}
                        </option>
                    </select>
                    <label for="fromCity" 
                           class="pointer-events-none absolute text-xl text-gray-500 duration-300 transform 
                                scale-75 top-4 z-10 origin-[0] left-10 
                                peer-valid:-translate-y-4 peer-valid:text-sm
                                peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm">
                        Điểm đi
                    </label>
                </div>
                <div class="relative">
                    <MyDatePicker v-model="form.departureDate" :disable-past-dates="true" :theme="'light'" 
                    :label="'Ngày đi'" :disable-date-from="Date.now()" ref="departureDateRef" />
                </div>
            </div>

            <!-- To City & Return Date -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="relative  p-1">
                    <PlaneLanding class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500" />
                    <select v-model="form.toCity" id="toCity"
                            class="w-full h-14 p-3 pt-5 pl-10 rounded-lg border border-gray-300 focus:ring-1 focus:ring-orange-500 focus:border-orange-500 outline-none peer appearance-none"
                            required ref="toCityRef">
                        <option value="" disabled selected></option>
                        <option v-for="airport in filteredSelectableAirportsTo" 
                                :key="airport.airportCode" 
                                :value="airport.airportCode">
                            {{airport.city}}
                        </option>
                    </select>
                    <label for="toCity" 
                           class="pointer-events-none absolute text-xl text-gray-500 duration-300 transform 
                                scale-75 top-4 z-10 origin-[0] left-10 
                                peer-valid:-translate-y-4 peer-valid:text-sm
                                peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm">
                        Điểm đến
                    </label>
                </div>
                
                <div v-if="form.ticketType === 'round-trip'" class="relative group">
                    <MyDatePicker v-model="form.returnDate" :disable-past-dates="true" 
                    label="Ngày về" :disable-date-from="Math.max(form.departureDate, Date.now())" ref="returnDateRef"/>
                </div>
            </div>

            <!-- Ticket Details -->
            <div class="space-y-2">
                <label for="ticketDetails" class="block text-sm font-medium text-gray-700">Số vé (Tối đa 10 vé)</label>
                <input type="text" id="ticketDetails" :value="ticketSummary" @click="toggleTicketModal" 
                       class="w-full p-3 rounded-lg border border-gray-300 cursor-pointer bg-gray-50"
                       readonly placeholder="Nhấn để chỉnh sửa số vé" ref="ticketDetailsRef" />
                
                <!-- Ticket Modal -->
                <div v-if="isModalVisible" 
                     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                    <div class="bg-white rounded-xl p-6 w-96 space-y-4">
                        <div class="space-y-2">
                            <label for="adults" class="block text-sm font-medium text-gray-700">Số vé người lớn</label>
                            <input type="number" id="adults" v-model="form.adults" :min="1" :max="maxAdults"
                                   class="w-full p-3 rounded-lg border border-gray-300" />
                        </div>
                        <div class="space-y-2">
                            <label for="children" class="block text-sm font-medium text-gray-700">Số vé trẻ em</label>
                            <input type="number" id="children" v-model="form.children" min="0" :max="maxChildren"
                                   class="w-full p-3 rounded-lg border border-gray-300" />
                        </div>
                        <button type="button" @click="closeModal"
                                class="w-full py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors">
                            Xong
                        </button>
                    </div>
                </div>
            </div>

            <!-- Error Message -->
            <div v-if="error" class="p-4 bg-red-50 text-red-600 rounded-lg">
                {{ error }}
            </div>

            <!-- Submit Button -->
            <button type="submit" 
                    :disabled="isSubmitDisabled"
                    class="w-full py-3 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed">
                Tìm kiếm
            </button>
        </form>

        <!-- Ticket Search Form -->
        <form @submit.prevent="submitFormTicket" v-if="content == 'searchTicket'" class="space-y-6">
            <div class="relative">
                <BookCheck class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500" />
                <input type="text" v-model="form2.seatCode" id="seatCode"
                       class="w-full h-14 p-3 pt-5 pl-10 rounded-lg border border-gray-300 
                            focus:ring-2 focus:ring-orange-200 focus:border-orange-500 
                            outline-none peer appearance-none" 
                        required/>
                <label for="seatCode" 
                       class="pointer-events-none absolute text-xl text-gray-500 duration-300 transform 
                                scale-75 top-4 z-10 origin-[0] left-10 
                                peer-valid:-translate-y-4 peer-valid:text-sm
                                peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm">
                    Mã đặt chỗ
                </label>
            </div>
            <div class="relative">
                <BookUser class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500" />
                <input type="text" v-model="form2.firstName" id="firstName"
                       class="w-full h-14 p-3 pt-5 pl-10 rounded-lg border border-gray-300 
                            focus:ring-2 focus:ring-orange-200 focus:border-orange-500 
                            outline-none peer appearance-none" 
                        required/>
                <label for="firstName" 
                       class="pointer-events-none absolute text-xl text-gray-500 duration-300 transform 
                                scale-75 top-4 z-10 origin-[0] left-10 
                                peer-valid:-translate-y-4 peer-valid:text-sm
                                peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm">
                    Họ
                </label>
            </div>
            
            <div v-if="error" class="p-4 bg-red-50 text-red-600 rounded-lg">
                {{ error }}
            </div>

            <button type="submit" 
                    :disabled="isSubmitDisabled"
                    class="w-full py-3 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed">
                Tìm kiếm
            </button>
        </form>
    </div>
</div>
</template>

<script setup>
import { ref, computed,defineEmits ,onMounted, nextTick, watch} from 'vue'
import { searchFlightStore} from '@/store/searchFlight';
import { PlaneTakeoff, PlaneLanding, BookCheck, BookUser} from 'lucide-vue-next';
import MyDatePicker from '../composable/form/MyDatePicker.vue';

const airports = ref([])

onMounted(async () => {
  try {
    const  response = await fetch('http://localhost:8080/api/airport/public/airportList', {
            method : 'Get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
            }
        });
    const data = await response.json()
    airports.value = data
  } catch (error) {
    console.error('Error fetching airports:', error)
  }
})

const filteredSelectableAirportsFrom = computed(() => {
    return airports.value.filter(airport => airport.airportCode !== form.value.toCity);
});

// Computed property for filtering airports for the "Điểm đến" (destination) city
const filteredSelectableAirportsTo = computed(() => {
  return airports.value.filter(airport => airport.airportCode !== form.value.fromCity);
});
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

// Add refs for form elements
const fromCityRef = ref(null)
const toCityRef = ref(null)
const departureDateRef = ref(null)
const returnDateRef = ref(null)
const ticketDetailsRef = ref(null)

// Add watch handlers for form fields
watch(() => form.value.fromCity, async (newVal) => {
  if (newVal) {
    await nextTick()
    departureDateRef.value?.$el.querySelector('input').focus()
  }
})

watch(() => form.value.toCity, async (newVal) => {
  if (newVal) {
    await nextTick()
    
    if (form.value.ticketType === 'round-trip') {
      returnDateRef.value?.$el.querySelector('input').focus()
    } else {
      ticketDetailsRef.value?.focus()
    }
  }
})

watch(() => form.value.departureDate, async (newVal) => {
  if (newVal) {
    await nextTick()
    toCityRef.value?.focus()
  }
})

watch(() => form.value.returnDate, async (newVal) => {
  if (newVal) {
    await nextTick()
    ticketDetailsRef.value?.focus()
  }
})
</script>

<style scoped>

</style>
