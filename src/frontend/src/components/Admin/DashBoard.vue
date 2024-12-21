<template>
  <div class="min-h-screen bg-gradient-to-br from-red-50 to-orange-100 p-6">
    <header class="flex items-center justify-between mb-8">
      <div class="flex items-center space-x-4">
        <EagleSVG class="text-red-600" />
        <h1 class="text-3xl font-bold text-red-800">Airline Admin Dashboard</h1>
      </div>
    </header>

    <div class="grid grid-cols-3 gap-6">
      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-red-500">
        <div class="flex justify-between items-center mb-4">
          <PlaneSVG class="text-red-500" />
          <span class="text-2xl font-bold text-red-700">{{ totalTicket }}</span>
        </div>
        <h2 class="text-lg font-semibold text-gray-800">Tổng số vé đã đặt</h2>
        <p class="text-sm text-gray-500">Trong năm</p>
      </div>

      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-orange-500">
        <div class="flex justify-between items-center mb-4">
          <UsersSVG class="text-orange-500" />
          <span class="text-2xl font-bold text-orange-700">12,456</span>
        </div>
        <h2 class="text-lg font-semibold text-gray-800">Tổng số hành khách</h2>
        <p class="text-sm text-gray-500">Trong năm</p>
      </div>

      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-red-700">
        <div class="flex justify-between items-center mb-4">
          <ChartSVG class="text-red-700" />
          <span class="text-2xl font-bold text-red-900">$2.3M</span>
        </div>
        <h2 class="text-lg font-semibold text-gray-800">Total Revenue</h2>
        <p class="text-sm text-gray-500">Current Quarter</p>
      </div>
    </div>
    <div class="text-center mt-4">
      <h3 class="text-xl font-bold">Tổng số chuyến bay: {{ totalTicket }}</h3>
    </div>
    <div class="flex justify-center space-x-4 my-4">
      <button @click="changePeriod('daily')" :class="['px-4 py-2 rounded-lg', selectedPeriod === 'daily' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700']">Daily</button>
      <button @click="changePeriod('monthly')" :class="['px-4 py-2 rounded-lg', selectedPeriod === 'monthly' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700']">Monthly</button>
      <button @click="changePeriod('yearly')" :class="['px-4 py-2 rounded-lg', selectedPeriod === 'yearly' ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-700']">Yearly</button>
    </div>
    <div class="mt-4">
      <canvas id="verticalBarChart" width="400" height="200"></canvas>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue'
import Chart from 'chart.js/auto'

export default {
  name: 'AirlineDashboard',
  components: {
    EagleSVG: {
      template: `
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-12 h-12">
          <path d="M12 2L2 7l10 5 10-5-10-5z"/>
          <path d="M2 17l10 5 10-5M2 12l10 5 10-5"/>
        </svg>
      `
    },
    PlaneSVG: {
      template: `
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10">
          <path d="M22 16v-2l-8.5-5V3.5c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5V9l-8.5 5v2l8.5-2.5V19l-2 1.5V22l3.5-1 3.5 1v-1.5L13.5 19v-5.5L22 16z"/>
        </svg>
      `
    },
    ChartSVG: {
      template: `
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10">
          <path d="M4 9h4v11H4zm6-5h4v16h-4zm6 8h4v8h-4z"/>
        </svg>
      `
    },
    UsersSVG: {
      template: `
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-10 h-10">
          <path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z"/>
        </svg>
      `
    }
  },
  setup() {
    const chart = ref(null)
    const bookings = ref([])

    const totalTicket = computed(() => bookings.value.length)

    const fetchBookings = async () => {
      try {
        const response = await fetch('http://localhost:8080/api/flight/admin_flight/getTicketList', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${localStorage.getItem('adminToken')}`
          }
        });
        const data = await response.json();
        bookings.value = data;
        getChartData();
        console.log('Fetched bookings:', data);
      } catch (error) {
        console.error('Error fetching bookings:', error);
      }
    }

    const labelData = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

    const getChartData = () => {
      const monthlyData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
      bookings.value.forEach(booking => {
        const month = new Date(booking.bookingDate).getMonth();
        monthlyData[month] += 1;
      })
      console.log('Monthly data:', monthlyData);
      return monthlyData;
    } 

    const initializeChart = () => {
      const ctx = document.getElementById('verticalBarChart').getContext('2d');
      chart.value = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: labelData,
          datasets: [{
            label: 'Số vé đã đặt',
            data: getChartData(),
            backgroundColor: 'rgba(54, 162, 235, 0.5)',
            borderColor: 'rgb(54, 162, 235)',
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          scales: {
            y: {
              beginAtZero: true
            }
          }
        }
      })
    }

    onMounted(async () => {
      await fetchBookings();
      initializeChart();
    })

    return {
      totalTicket,
      bookings
    }
  }
}
</script>