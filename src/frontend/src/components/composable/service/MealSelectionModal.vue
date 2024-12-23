<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[90vh] overflow-y-auto">
      <!-- Modal Header -->
      <div class="flex justify-between items-center p-6 border-b border-yellow-500">
        <h2 class="text-2xl font-bold flex items-center text-orange-600">
          <Utensils class="h-8 w-8 mr-5"/> Chọn Suất Ăn
        </h2>
        <button @click="$emit('close')" class="text-gray-500 hover:text-orange-600 transition-colors">
          <X class="h-8 w-8 hover:rotate-90 transition-all duration-300 hover:scale-125"/>
        </button>
      </div>

      <!-- Outbound Meal Selection -->
      <div class="p-6">
        <h3 class="text-xl font-semibold mb-4 text-orange-600">Chọn Suất Ăn Chiều Đi (Tối đa {{ maxTickets }} suất)</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div v-for="meal in meals" :key="meal.id" class="border rounded-lg overflow-hidden relative" :class="{
            'border-yellow-500 ring-2 ring-yellow-300': (outboundMeals[meal.id] || 0) > 0,
            'hover:border-yellow-300': true
          }">
            <img :src="require(`@/assets/meal/${meal.image}`)" :alt="meal.name" class="w-full h-48 object-cover" />
            <div class="p-4">
              <h4 class="font-bold text-lg text-orange-600 h-8">{{ meal.name }}</h4>
              <p class="text-sm text-gray-600 mb-2 h-10">{{ meal.description }}</p>
              <div class="flex justify-between items-center">
                <span class="text-yellow-600 font-semibold">
                  {{ formatCurrency(meal.price) }}
                </span>
                <span class="text-xs bg-orange-100 px-2 py-1 rounded">
                  {{ meal.dietaryInfo }}
                </span>
              </div>

              <!-- Quantity Control -->
              <div class="flex items-center justify-between mt-4">
                <button @click="decreaseMealQuantity(meal, 'outbound')" :disabled="(outboundMeals[meal.id] || 0) <= 0" class="bg-yellow-200 text-gray-700 rounded-l px-2 py-1 disabled:opacity-50">
                  -
                </button>
                <span class="px-4 py-1 bg-yellow-100">
                  {{ outboundMeals[meal.id] || 0 }}
                </span>
                <button @click="increaseMealQuantity(meal, 'outbound')" :disabled="totalOutboundMeals >= maxTickets" class="bg-yellow-200 text-gray-700 rounded-r px-2 py-1 disabled:opacity-50">
                  +
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Return Meal Selection (if round trip) -->
      <div v-if="isRoundTrip" class="p-6 border-t">
        <h3 class="text-xl font-semibold mb-4 text-orange-600">Chọn Suất Ăn Chiều Về (Tối đa {{ maxTickets }} suất)</h3>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div v-for="meal in meals" :key="meal.id" class="border rounded-lg overflow-hidden relative" :class="{
            'border-yellow-500 ring-2 ring-yellow-300': (returnMeals[meal.id] || 0) > 0,
            'hover:border-yellow-300': true
          }">
            <img :src="meal.image" :alt="xxx" class="w-full h-48 object-cover" />
            <div class="p-4">
              <h4 class="font-bold text-lg text-orange-600">{{ meal.name }}</h4>
              <p class="text-sm text-gray-600 mb-2">{{ meal.description }}</p>
              <div class="flex justify-between items-center">
                <span class="text-yellow-600 font-semibold">
                  {{ formatCurrency(meal.price) }}
                </span>
                <span class="text-xs bg-orange-100 px-2 py-1 rounded">
                  {{ meal.dietaryInfo }}
                </span>
              </div>

              <!-- Quantity Control -->
              <div class="flex items-center justify-between mt-4">
                <button @click="decreaseMealQuantity(meal, 'return')" :disabled="(returnMeals[meal.id] || 0) <= 0" class="bg-yellow-200 text-gray-700 rounded-l px-2 py-1 disabled:opacity-50">
                  -
                </button>
                <span class="px-4 py-1 bg-yellow-100">
                  {{ returnMeals[meal.id] || 0 }}
                </span>
                <button @click="increaseMealQuantity(meal, 'return')" :disabled="totalReturnMeals >= maxTickets" class="bg-yellow-200 text-gray-700 rounded-r px-2 py-1 disabled:opacity-50">
                  +
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <div class="p-6 border-t flex justify-between items-center bg-amber-50">
        <div>
          <p class="font-semibold text-orange-600">
            Tổng chi phí:
            <span class="text-yellow-600 ml-2">
              {{ formatCurrency(totalPrice) }}
            </span>
          </p>
          <p class="text-sm text-gray-600">
            Đã chọn: {{ totalOutboundMeals + (isRoundTrip ? totalReturnMeals : 0) }}/{{ maxTickets }} suất ăn
          </p>
        </div>
        <div class="space-x-4">
          <button class="px-4 py-2 bg-gray-100 text-gray-800 rounded border border-gray-300 hover:bg-gray-200" @click="$emit('close')">
            Hủy
          </button>
          <button class="px-4 py-2 bg-orange-500 text-white rounded hover:bg-orange-700 disabled:opacity-50 cursor-pointer" 
          @click="handleConfirm"
          :disabled="!isSelectionValid">
            Xác Nhận
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, defineProps, defineEmits,  } from 'vue'
import { Utensils, X } from 'lucide-vue-next'


const props = defineProps({
  isRoundTrip: {
    type: Boolean,
    default: false
  },
  maxTickets: {
    type: Number,
    default: 0
  },
  propOutboundMeals: {
    type: Object,
    default: () => {} 
  },
  propReturnMeals: {
    type: Object,
    default: () => {} 
  },
  meals: {
    type: Array,
    default: () => []
  }
})


const emit = defineEmits(['confirm', 'close'])


const outboundMeals = ref({...props.propOutboundMeals})
const returnMeals = ref({...props.propReturnMeals})

const totalPrice = computed(() => {
  let total = 0
  Object.keys(outboundMeals.value).forEach(mealId => {
    console.log("mealId: ", mealId)
    const meal = props.meals.find(m => m.id === parseInt(mealId))
    total += (meal.price * outboundMeals.value[mealId])
  })
  
  if (props.isRoundTrip) {
    Object.keys(returnMeals.value).forEach(mealId => {
      const meal = props.meals.find(m => m.id === parseInt(mealId))
      total += (meal.price * returnMeals.value[mealId])
    })
  }
  return total
})

const totalOutboundMeals = computed(() => {
  return Object.values(outboundMeals.value).reduce((sum, qty) => sum + qty, 0)
})

const totalReturnMeals = computed(() => {
  return Object.values(returnMeals.value).reduce((sum, qty) => sum + qty, 0)
})

const isSelectionValid = computed(() => {
  return totalOutboundMeals.value <= props.maxTickets && 
    (!props.isRoundTrip || totalReturnMeals.value <= props.maxTickets)
})

const increaseMealQuantity = (meal, type) => {
  const mealCollection = type === 'outbound' ? outboundMeals : returnMeals
  const totalMeals = type === 'outbound' ? totalOutboundMeals.value : totalReturnMeals.value
  
  if (totalMeals < props.maxTickets) {
    mealCollection.value[meal.id] = (mealCollection.value[meal.id] || 0) + 1
  }
}

const decreaseMealQuantity = (meal, type) => {
  const mealCollection = type === 'outbound' ? outboundMeals : returnMeals
  
  if (mealCollection.value[meal.id] > 0) {
    mealCollection.value[meal.id] -= 1
    if (mealCollection.value[meal.id] === 0) {
      delete mealCollection.value[meal.id]
    }
  }
}

const formatCurrency = (value) => {
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND'
  }).format(value)
}

const handleConfirm = () => {
  emit('confirm', {
    outboundMeals: outboundMeals.value,
    returnMeals: returnMeals.value,
    totalPrice: totalPrice.value
  })
  emit('close')
}


</script>
