<template>
  <div class="relative" ref="datePickerRef">
    <!-- Input với style nâng cao -->
    <div class="relative p-1 bg-transparent group">
      <input 
        type="text" 
        :value="formattedDate" 
        @click="toggleCalendar"
        @focus="toggleCalendar"
        readonly
        class="w-full h-14 pl-10 pr-4 py-3 rounded-lg border transition duration-300 peer 
              outline-none  focus:border-orange-400 focus:ring-2 ring-orange-200
              tracking-wider"
              :class="[isCalendarOpen ? 'border-orange-500 ring-2' : 'border-gray-300']"
        required
      />
      <label for="returnDate" 
              class="pointer-events-none absolute duration-300 transform  
                  scale-75 top-4 origin-[0] left-10
                  peer-focus:-translate-y-4 peer-focus:text-orange-500 peer-focus:text-sm"
              :class="[isCalendarOpen ? 'text-orange-500 text-sm -translate-y-4' : 'text-gray-500 text-xl',
                      formattedDate ? '!text-sm -translate-y-4' : ''
              ]">
         {{ label }}
      </label>
      <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
        <svg 
          xmlns="http://www.w3.org/2000/svg" 
          class="h-6 w-6 group-focus-within:text-orange-500" 
          :class="[isCalendarOpen ? 'text-orange-500' : 'text-gray-500']"
          fill="none" 
          viewBox="0 0 24 24" 
          stroke="currentColor"
        >
          <path 
            stroke-linecap="round" 
            stroke-linejoin="round" 
            stroke-width="2" 
            d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" 
          />
        </svg>
      </div>
    </div>

    <!-- Calendar dropdown với animation và shadow -->
    <transition 
      enter-active-class="transition ease-out duration-300"
      enter-from-class="opacity-0 scale-95"
      enter-to-class="opacity-100 scale-100"
      leave-active-class="transition ease-in duration-200"
      leave-from-class="opacity-100 scale-100"
      leave-to-class="opacity-0 scale-95"
    >
      <div 
        v-if="isCalendarOpen" 
        class="absolute z-20 mt-2 bg-white rounded-xl shadow-2xl border border-gray-100 overflow-hidden w-64"
      >
        <!-- Header với gradient và icon -->
        <div class="bg-gradient-to-r from-blue-500 to-purple-600 text-white p-4 flex items-center justify-between">
          <button 
            @click="previousMonth" 
            class="hover:bg-white/20 p-2 rounded-full transition"
            type="button"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd" />
            </svg>
          </button>
          <span class="text-lg font-semibold tracking-wider">
            {{ currentMonthYear }}
          </span>
          <button 
            @click="nextMonth" 
            class="hover:bg-white/20 p-2 rounded-full transition"
            type="button"
          >
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
          </button>
        </div>

        <!-- Weekdays header -->
        <div class="grid grid-cols-7 text-center text-xs text-gray-500 bg-gray-100 py-2">
          <div v-for="day in weekdays" :key="day" class="font-bold">{{ day }}</div>
        </div>

        <!-- Calendar grid với hover và transition -->
        <div class="grid grid-cols-7 gap-1 p-3">
          <button type="button"
            v-for="day in calendarDays" 
            :key="day.date" 
            @click="handleClickOnDate(day)"
            :disabled="day.disabled"
            :class="[
              'py-2 text-sm rounded-lg transition duration-200 ease-in-out',
              day.selected 
                ? 'bg-blue-500 text-white hover:bg-blue-600' 
                : day.preview
                  ? 'bg-blue-200 text-blue-700'
                  : day.inRange
                    ? 'bg-blue-100 text-blue-600'
                    : day.current 
                      ? 'text-gray-800 hover:bg-blue-100 hover:text-blue-600' 
                      : 'text-gray-300 cursor-not-allowed',
              day.disabled ? 'opacity-50' : ''
            ]"
          >
            {{ day.day }}
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted,defineEmits,defineProps } from 'vue'

const props = defineProps({
  modelValue: {
    type: [Date, String], // Thêm kiểu String
    default: null,
    // Thêm validator để chuyển đổi chuỗi rỗng thành null
    validator: (value) => {
      if (value === '') return true
      return value instanceof Date || value === null
    }
  },
  disableDateFrom: {
    type: [Date, String], // Thêm kiểu String
    default: null,
    // Thêm validator để chuyển đổi chuỗi rỗng thành null
    validator: (value) => {
      if (value === '') return true
      return value instanceof Date || value === null
    }
  },
  label: {
    type: String,
    default: ''
  },
  range: {
    type: Boolean,
    default: false
  }
})

const emit = defineEmits(['update:modelValue'])

const isCalendarOpen = ref(false)
const currentDate = ref(new Date())
const selectedDate = ref(props.modelValue || null)
const datePickerRef = ref(null)

const weekdays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN']

const toggleCalendar = () => {
  isCalendarOpen.value = true
}

// Hàm xử lý click ngoài
const handleClickOutside = async (event) => {
  if (datePickerRef.value && !datePickerRef.value.contains(event.target)) {
    isCalendarOpen.value = false
  }
}

// Thêm sự kiện click toàn cục khi component được mount
onMounted(() => {
  document.addEventListener('dblclick', handleClickOutside)
})

// Gỡ bỏ sự kiện khi component bị unmount để tránh memory leak
onUnmounted(() => {
  document.removeEventListener('dblclick', handleClickOutside)
})

const formattedDate = computed(() => {
  return props.modelValue 
    ? props.modelValue.toLocaleDateString('vi-VN') 
    : null
})

const currentMonthYear = computed(() => {
  return "Tháng " + (currentDate.value.getMonth() + 1) + "/" + currentDate.value.getFullYear();
})

const calendarDays = computed(() => {
  const year = currentDate.value.getFullYear()
  const month = currentDate.value.getMonth()
  const firstDayOfMonth = new Date(year, month, 1)
  const lastDayOfMonth = new Date(year, month + 1, 0)
  const days = []

  // Chuyển đổi disableDateFrom thành Date object nếu nó là string
  const disableDateFrom = props.disableDateFrom instanceof Date 
    ? props.disableDateFrom 
    : props.disableDateFrom 
      ? new Date(props.disableDateFrom)
      : null

  // Thêm các ngày từ tháng trước để lấp đầy tuần
  const startingDay = firstDayOfMonth.getDay() || 7
  for (let i = 1; i < startingDay; i++) {
    days.push({ day: '', disabled: true })
  }

  // Thêm các ngày trong tháng
  for (let day = 1; day <= lastDayOfMonth.getDate(); day++) {
    const date = new Date(year, month, day)
    const isInRange = props.range && disableDateFrom && selectedDate.value && 
      date >= disableDateFrom && date <= selectedDate.value
    const isStartDate = disableDateFrom && 
      date.toDateString() === disableDateFrom.toDateString()

    days.push({
      day,
      date,
      current: true,
      selected: selectedDate.value && date.toDateString() === selectedDate.value.toDateString(),
      disabled: disableDateFrom 
        ? date < disableDateFrom 
        : false,
      inRange: isInRange,
      isStartDate
    })
  }

  return days
})

const handleClickOnDate = (day) => {
  if (day.current && !day.disabled) {
    selectedDate.value = day.date
    emit('update:modelValue', day.date)
    isCalendarOpen.value = false
  }
}

const previousMonth = () => {
  currentDate.value = new Date(
    currentDate.value.getFullYear(), 
    currentDate.value.getMonth() - 1, 
    1
  )
}

const nextMonth = () => {
  currentDate.value = new Date(
    currentDate.value.getFullYear(), 
    currentDate.value.getMonth() + 1, 
    1
  )
}
</script>