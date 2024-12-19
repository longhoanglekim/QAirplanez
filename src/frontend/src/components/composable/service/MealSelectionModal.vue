<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-4xl max-h-[90vh] overflow-y-auto">
      <!-- Modal Header -->
      <div class="flex justify-between items-center p-6 border-b border-yellow-500">
        <h2 class="text-2xl font-bold flex items-center text-orange-600">
          <Utensils class="h-8 w-8 mr-5"/> Chọn Suất Ăn
          Chọn Suất Ăn
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
            <img :src="meal.image" :alt="meal.name" class="w-full h-48 object-cover" />
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
            <img :src="meal.image" :alt="meal.name" class="w-full h-48 object-cover" />
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

<script>
import { Utensils, X } from 'lucide-vue-next';
export default {
  name: 'AirplaneMealModal',
  props: {
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
    }
  },
  components: {
    Utensils, X
  },
  data() {
    return {
      meals: [
        {
          id: 1,
          name: "Cơm gà Nhật",
          description: "Cơm gà nướng kiểu Nhật với sốt teriyaki",
          price: 55000,
          image: "/api/placeholder/300/200?text=Cơm+gà+Nhật",
          dietaryInfo: "Gluten-free"
        },
        {
          id: 2,
          name: "Salad rau đặc biệt",
          description: "Salad tươi với các loại rau hữu cơ",
          price: 125000,
          image: "/api/placeholder/300/200?text=Salad+rau",
          dietaryInfo: "Vegetarian"
        },
        {
          id: 3,
          name: "Bò bít tết Âu",
          description: "Bò nướng với khoai tây chiên và sốt",
          price: 200000,
          image: "/api/placeholder/300/200?text=Bò+bít+tết",
          dietaryInfo: "Không chứa sữa"
        }
      ],
      outboundMeals: {...this.propOutboundMeals},
      returnMeals: {...this.propReturnMeals}
    };
  },
  computed: {
    totalPrice() {
      let total = 0;
      Object.keys(this.outboundMeals).forEach(mealId => {
        console.log('mealId', mealId)
        const meal = this.meals.find(m => m.id === parseInt(mealId));
        total += (meal.price * this.outboundMeals[mealId]);
      });
      if (this.isRoundTrip) {
        Object.keys(this.returnMeals).forEach(mealId => {
          const meal = this.meals.find(m => m.id === parseInt(mealId));
          total += (meal.price * this.returnMeals[mealId]);
        });
      }
      return total;
    },
    totalOutboundMeals() {
      return Object.values(this.outboundMeals).reduce((sum, qty) => sum + qty, 0);
    },
    totalReturnMeals() {
      return Object.values(this.returnMeals).reduce((sum, qty) => sum + qty, 0);
    },
    isSelectionValid() {
      return this.totalOutboundMeals <= this.maxTickets
        &&(!this.isRoundTrip || this.totalReturnMeals <= this.maxTickets);
    }
  },
  methods: {
    increaseMealQuantity(meal, type) {
      const mealCollection = type === 'outbound' ? this.outboundMeals : this.returnMeals;
      const totalMeals = type === 'outbound' ? this.totalOutboundMeals : this.totalReturnMeals;
      if (totalMeals < this.maxTickets) {
        mealCollection[meal.id] = (mealCollection[meal.id] || 0) + 1;
      }
    },
    decreaseMealQuantity(meal, type) {
      const mealCollection = type === 'outbound' ? this.outboundMeals : this.returnMeals;
      if (mealCollection[meal.id] > 0) {
        mealCollection[meal.id] -= 1;
        if (mealCollection[meal.id] === 0) {
          delete mealCollection[meal.id];
        }
      }
    },
    formatCurrency(value) {
      return new Intl.NumberFormat('vi-VN', {
        style: 'currency',
        currency: 'VND'
      }).format(value);
    },
    handleConfirm() {

      this.$emit('confirm', {
        outboundMeals: this.outboundMeals,
        returnMeals: this.returnMeals,
        totalPrice: this.totalPrice
      });
      this.$emit('close')
    }
  }
};
</script>
