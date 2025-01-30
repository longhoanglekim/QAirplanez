<template>
<div class="w-full rounded-xl shadow-lg  bg-white m-4 text-left max-w-sm">
    <!-- Tab buttons -->
    <div class="rounded-t-xl bg-gray-100 relative p-4">
        <button @click="changeContent('searchFlight')" 
                class="text-md w-32 font-medium transition-colors duration-200" 
                :class="{'text-orange-500': content == 'searchFlight', 'text-gray-600': content != 'searchFlight'}">
            Tìm chuyến bay
        </button>
        <button @click="changeContent('searchTicket')" 
                class="text-md w-32 font-medium transition-colors duration-200" 
                :class="{'text-orange-500': content == 'searchTicket', 'text-gray-600': content != 'searchTicket'}">
            Tra cứu vé
        </button>
        <span class="absolute bottom-0 w-32 border-b-4 border-orange-500 transition-all duration-300"
              :class="{'left-4': content == 'searchFlight', 'left-36': content == 'searchTicket'}">
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
            <div class="grid grid-cols-2">
                <div class="relative group p-1">
                    <PlaneTakeoff class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500 group-focus-within:text-orange-500" />
                    
                    <input
                      type="text"
                      v-model="searchFromCity"
                      @focus="showFromDropdown = true"
                      @input="filterFromCities()"
                      class="w-full h-14 p-3 pt-5 pl-10 rounded-lg border border-gray-300 
                             focus:ring-2 focus:ring-orange-200 focus:border-orange-500 
                             outline-none peer"
                      ref="fromCityRef"
                      required
                    />

                    <label for="fromCity" 
                           class="pointer-events-none absolute text-xl text-gray-500 duration-300 transform 
                                scale-75 top-4 z-10 origin-[0] left-10 
                                peer-valid:-translate-y-4 peer-valid:text-sm
                                peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm">
                        Điểm đi
                    </label>

                    <!-- Dropdown list -->
                    <div v-if="showFromDropdown && filteredCitiesFrom.length > 0" 
                         class="absolute z-50 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                      <div v-for="airport in filteredCitiesFrom" 
                           :key="airport.airportCode"
                           @click="selectFromCity(airport)"
                           class="p-3 hover:bg-orange-50 cursor-pointer">
                        {{ airport.city }}
                      </div>
                    </div>
                </div>
                <div class="relative">
                    <MyDatePicker v-model="form.departureDate" label="Ngày đi" 
                    :disable-date-from="Date.now()" ref="departureDateRef" />
                </div>
            </div>

            <!-- To City & Return Date -->
            <div class="grid grid-cols-2">
                <div class="relative p-1 group">
                    <PlaneLanding class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500 group-focus-within:text-orange-500" />
                    <input type="text" v-model="searchToCity" 
                      @focus="showToDropdown = true; filterToCities()" 
                      @input="showToDropdown = true; filterToCities()"
                      class="w-full h-14 p-3 pt-5 pl-10 rounded-lg border border-gray-300 
                            focus:ring-2 focus:ring-orange-200 focus:border-orange-500 
                            outline-none peer"
                      ref="toCityRef" 
                      required
                    />
                    <label for="toCity" 
                           class="pointer-events-none absolute text-xl text-gray-500 duration-300 transform 
                                scale-75 top-4 z-10 origin-[0] left-10 
                                peer-valid:-translate-y-4 peer-valid:text-sm
                                peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm">
                        Điểm đến
                    </label>
                    <!-- To City Dropdown -->
                    <div v-if="showToDropdown && filteredCitiesTo.length > 0" 
                         class="absolute z-50 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                      <div v-for="airport in filteredCitiesTo" 
                           :key="airport.airportCode"
                           @click="selectToCity(airport)"
                           class="p-3 hover:bg-orange-50 cursor-pointer">
                        {{ airport.city }}
                      </div>
                    </div>
                </div>
                
                <div v-if="form.ticketType === 'round-trip'" class="relative group">
                    <MyDatePicker v-model="form.returnDate" label="Ngày về"
                    :disable-date-from="new Date(Math.max(form.departureDate, Date.now()))" 
                    :range="true"  ref="returnDateRef"/>
                </div>
            </div>

            <!-- Ticket Details -->
            <div class="space-y-2">
                <label for="ticketDetails" class="block text-sm font-medium text-gray-700">Số vé (Tối đa 10 vé)</label>
                <input type="text" id="ticketDetails" :value="ticketSummary" @click="toggleTicketModal" 
                       class="w-full p-3 rounded-lg border border-gray-300 cursor-pointer bg-gray-50 outline-none
                              focus:ring-2 focus:ring-orange-200 focus:border-orange-500"
                              :class="[isModalVisible ? 'ring-2 ring-orange-500' : '']"
                       readonly placeholder="Nhấn để chỉnh sửa số vé" ref="ticketDetailsRef" />
                
                <!-- Ticket Modal -->
                <div v-if="isModalVisible" 
                     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                    <div class="bg-white rounded-xl p-6 w-96 space-y-4">
                        <div class="space-y-2">
                            <label for="adults" class="block text-sm font-medium text-gray-700">Số vé người lớn</label>
                            <div class="flex items-center">
                                <button type="button" @click="decreaseAdults" 
                                        class="p-3 rounded-l-lg border border-gray-300 hover:bg-gray-100">
                                    -
                                </button>
                                <input type="number" id="adults" v-model="form.adults" :min="1" :max="maxAdults"
                                       class="w-full p-3 border-y border-gray-300 text-center" />
                                <button type="button" @click="increaseAdults"
                                        class="p-3 rounded-r-lg border border-gray-300 hover:bg-gray-100">
                                    +
                                </button>
                            </div>
                        </div>
                        <div class="space-y-2">
                            <label for="children" class="block text-sm font-medium text-gray-700">Số vé trẻ em</label>
                            <div class="flex items-center">
                                <button type="button" @click="decreaseChildren"
                                        class="p-3 rounded-l-lg border border-gray-300 hover:bg-gray-100">
                                    -
                                </button>
                                <input type="number" id="children" v-model="form.children" min="0" :max="maxChildren"
                                       class="w-full p-3 border-y border-gray-300 text-center" />
                                <button type="button" @click="increaseChildren"
                                        class="p-3 rounded-r-lg border border-gray-300 hover:bg-gray-100">
                                    +
                                </button>
                            </div>
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
            <div class="flex justify-center">
                <button type="submit" 
                        :disabled="isSubmitDisabled"
                        class="w-full md:w-1/2 py-3 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed">
                    Tìm kiếm
                </button>
            </div>
            
        </form>

        <!-- Ticket Search Form -->
        <form @submit.prevent="submitFormTicket" v-if="content == 'searchTicket'" class="space-y-6">
            <div class="relative group">
                <BookCheck class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500 group-focus-within:text-orange-500" />
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
            <div class="relative group">
                <BookUser class="w-6 h-6 absolute top-1/2 -translate-y-1/2 left-2 text-gray-500 group-focus-within:text-orange-500" />
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

            <div class="flex justify-center">
                <button type="submit" 
                        :disabled="isSubmitDisabled"
                        class="w-full md:w-1/2 py-3 bg-orange-500 text-white rounded-lg hover:bg-orange-600 transition-colors disabled:opacity-50 disabled:cursor-not-allowed">
                    Tìm kiếm
                </button>
            </div>
        </form>
    </div>
</div>
</template>

<script setup>
import { ref, computed,defineEmits ,onMounted, nextTick, watch} from 'vue'
import { searchFlightStore} from '@/store/searchFlight';
import { PlaneTakeoff, PlaneLanding, BookCheck, BookUser} from 'lucide-vue-next';
import MyDatePicker from '@/components/composable/form/MyDatePicker.vue';
import { searchTicketStore } from '@/store/searchTicket';

const airports = ref([])
const emit = defineEmits(['search-flight', 'search-ticket'])
onMounted(async () => {
  try {
    const  response = await fetch('http://localhost:8080/api/airport/airportList', {
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

const storeTicket = searchTicketStore()

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
  if (form.value.children > form.value.adults) {
    error.value = 'Số vé trẻ em không được vượt quá số vé người lớn.'
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
  console.log("form đã lưu: ", form.value)

  // Emit event for parent component
  emit('search-flight')
}



function submitFormTicket() {
  error.value = ''
  storeTicket.saveForm(form2.value)
  emit('search-ticket', form2.value)
}

// Use defineEmits to define emitted events


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

function increaseAdults() {
    if (form.value.adults < maxAdults.value) {
        form.value.adults++
    }
}

function decreaseAdults() {
    if (form.value.adults > 1) {
        form.value.adults--
        // Đảm bảo số trẻ em không vượt quá số người lớn
        if (form.value.children >= form.value.adults) {
            form.value.children = form.value.adults - 1
        }
    }
}

function increaseChildren() {
    if (form.value.children < maxChildren.value) {
        form.value.children++
    }
}

function decreaseChildren() {
    if (form.value.children > 0) {
        form.value.children--
    }
}

const searchFromCity = ref(searchFStore.getOldForm().fromCityName)
const searchToCity = ref(searchFStore.getOldForm().toCityName)
const showFromDropdown = ref(false)
const showToDropdown = ref(false)
const filteredCitiesFrom = ref([])
const filteredCitiesTo = ref([])
function filterFromCities() {
  if (!searchFromCity.value) {
    filteredCitiesFrom.value = filteredSelectableAirportsFrom.value
  } else {
    filteredCitiesFrom.value = filteredSelectableAirportsFrom.value.filter(airport => 
      airport.city.toLowerCase().includes(searchFromCity.value.toLowerCase())
    )
  }
}

function filterToCities() {
  if (!searchToCity.value) {
    filteredCitiesTo.value = filteredSelectableAirportsTo.value
  } else {
    filteredCitiesTo.value = filteredSelectableAirportsTo.value.filter(airport => 
      airport.city.toLowerCase().includes(searchToCity.value.toLowerCase())
    )
  }
}

function selectFromCity(airport) {
  form.value.fromCity = airport.airportCode
  searchFromCity.value = airport.city
  showFromDropdown.value = false
  form.value.fromCityName = airport.city
}

function selectToCity(airport) {
  form.value.toCity = airport.airportCode
  searchToCity.value = airport.city
  showToDropdown.value = false
  form.value.toCityName = airport.city
}

onMounted(() => {
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.group')) {
      showFromDropdown.value = false
      showToDropdown.value = false
    }
  })
})

watch(() => airports.value, () => {
  filteredCitiesFrom.value = filteredSelectableAirportsFrom.value
}, { immediate: true })

watch(() => airports.value, () => {
  filteredCitiesTo.value = filteredSelectableAirportsTo.value
}, { immediate: true })

watch(() => form.value.fromCity, (newVal) => {
  if (newVal) {
    const selectedAirport = airports.value.find(airport => airport.airportCode === newVal)
    if (selectedAirport) {
      searchFromCity.value = selectedAirport.city
    }
  }
})

watch(() => form.value.toCity, (newVal) => {
  if (newVal) {
    const selectedAirport = airports.value.find(airport => airport.airportCode === newVal)
    if (selectedAirport) {
      searchToCity.value = selectedAirport.city
    }
  }
})


</script>

<style scoped>
/* Ẩn */
input[type="number"]::-webkit-inner-spin-button,
input[type="number"]::-webkit-outer-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

input[type="number"] {
    -moz-appearance: textfield; /* Firefox */
}


</style>
