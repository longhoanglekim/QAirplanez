<script setup>
import {ref, onMounted, onBeforeMount, computed } from 'vue';
import Chart from 'chart.js/auto';

/*
const avatarUrl = ref("https://via.placeholder.com/100");


const triggerFileUpload = () => {
    fileInputRef.value.click();
};

const handleAvatarChange = (event) => {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            avatarUrl.value = e.target.result; // Update avatarUrl with new image
        };
        reader.readAsDataURL(file); // Convert image to base64
    }
};

const fileInputRef = ref(null);
*/

// Chart Configuration
const DATA_SET_VERTICAL_BAR_CHART_1 = [68.106, 26.762, 94.255, 72.021, 74.082, 64.923, 85.565, 32.432, 54.664, 87.654, 43.013, 91.443];
const labels_vertical_bar_chart = ['January', 'February', 'Mart', 'April', 'May', 'Jun', 'July', 'August', 'September', 'October', 'November', 'December'];

const user = ref({
  firstname: "",
  lastname: "",
  birthdate: "",
  nationality: "",
  phoneNumber: "",
  email: "",
  dayAttemp: "",
});

const fullname = computed(() => {
  return `${user.value.firstname} ${user.value.lastname}`.trim(); // Kết hợp họ và tên
});

onBeforeMount(async () => {
  try {
    const response = await fetch('http://localhost:8080/api/user/currentUser', {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${localStorage.getItem('token')}`, // Include token if needed
      },
    });

    if (!response.ok) {
      // If the response is not OK, the token might be invalid or expired
      throw new Error('Unauthorized');
    } else {
      // Await the JSON response to get the user data
      const fetchedUser = await response.json();

      // Gán dữ liệu vào user.value
      user.value = {
        firstname: fetchedUser.firstname || '',
        lastname: fetchedUser.lastname || '',
        birthdate: fetchedUser.birthdate || '',
        nationality: fetchedUser.nationality || '',
        phoneNumber: fetchedUser.phoneNumber || '',
        email: fetchedUser.email || '',
        dayAttemp: fetchedUser.dayAttemp || ''
      };


    }
  } catch (error) {
    console.error('Error fetching user data:', error);
  }
});

onMounted(() => {
    const dataVerticalBarChart = {
        labels: labels_vertical_bar_chart,
        datasets: [
            {
                label: 'Revenue',
                data: DATA_SET_VERTICAL_BAR_CHART_1,
                borderColor: 'rgb(54, 162, 235)',
                backgroundColor: 'rgba(54, 162, 235, 0.5)',
            }
        ]
    };

    const configVerticalBarChart = {
        type: 'bar',
        data: dataVerticalBarChart,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Last 12 Months'
                }
            }
        },
    };

    new Chart(
        document.getElementById('verticalBarChart'),
        configVerticalBarChart
    );
});
</script>

<template>
    <div class="w-full h-[250px]">
        <img src="https://vojislavd.com/ta-template-demo/assets/img/profile-background.jpg"
            class="w-full h-full rounded-tl-lg rounded-tr-lg">
    </div>
    <div class="flex flex-col items-center -mt-20">
        <img src="https://vojislavd.com/ta-template-demo/assets/img/profile.jpg"
            class="w-40 border-4 border-white rounded-full">
        <div class="flex items-center space-x-2 mt-2">
            <p class="text-2xl">{{ fullname }}</p>
        </div>
        <p class="text-sm text-gray-500">{{user.nationality}}</p>
    </div>
    <div class="my-4 flex flex-col 2xl:flex-row space-y-4 2xl:space-y-0 2xl:space-x-4">
        <div class="w-full flex flex-col 2xl:w-1/3">
            <div class="flex-1 bg-white rounded-lg shadow-xl p-8">
                <h4 class="text-xl text-gray-900 font-bold">Thông tin cá nhân</h4>
                <ul class="mt-2 text-gray-700">
                    <li class="flex border-y py-2">
                        <span class="font-bold w-24">Họ và tên:</span>
                        <span class="text-gray-700">{{fullname }}</span>
                    </li>
                    <li class="flex border-b py-2">
                        <span class="font-bold w-24">Ngày sinh:</span>
                        <span class="text-gray-700">{{ user.birthdate }}</span>
                    </li>
                    <li class="flex border-b py-2">
                        <span class="font-bold w-24">Đã tham gia:</span>
                        <span class="text-gray-700">10 Jan 2022 (25 days ago)</span>
                    </li>
                    <li class="flex border-b py-2">
                        <span class="font-bold w-24">Số di động:</span>
                        <span class="text-gray-700">{{ user.phoneNumber }}</span>
                    </li>
                    <li class="flex border-b py-2">
                        <span class="font-bold w-24">Email:</span>
                        <span class="text-gray-700">{{ user.email }}</span>
                    </li>
                    <li class="flex border-b py-2">
                        <span class="font-bold w-24">Quốc tịch:</span>
                        <span class="text-gray-700">{{ user.lastname }}</span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="flex w-full 2xl:w-2/3">
            <div class="flex-1 bg-white rounded-lg shadow-xl mt-4 p-8">
                <h4 class="text-xl text-gray-900 font-bold">Thống kê</h4>

                <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mt-4">
                    <div class="px-6 py-6 bg-gray-100 border border-gray-300 rounded-lg shadow-xl">
                        <div class="flex items-center justify-between">
                            <span class="font-bold text-sm text-indigo-600">Total Revenue</span>
                            <span
                                class="text-xs bg-gray-200 hover:bg-gray-500 text-gray-500 hover:text-gray-200 px-2 py-1 rounded-lg transition duration-200 cursor-default">7
                                days</span>
                        </div>
                        <div class="flex items-center justify-between mt-6">
                            <div>
                                <svg class="w-12 h-12 p-2.5 bg-indigo-400 bg-opacity-20 rounded-full text-indigo-600 border border-indigo-600"
                                    fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                        d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                                    </path>
                                </svg>
                            </div>
                            <div class="flex flex-col">
                                <div class="flex items-end">
                                    <span class="text-2xl 2xl:text-3xl font-bold">$8,141</span>
                                    <div class="flex items-center ml-2 mb-1">
                                        <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                                        </svg>
                                        <span class="font-bold text-sm text-gray-500 ml-0.5">3%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="px-6 py-6 bg-gray-100 border border-gray-300 rounded-lg shadow-xl">
                        <div class="flex items-center justify-between">
                            <span class="font-bold text-sm text-green-600">New Orders</span>
                            <span
                                class="text-xs bg-gray-200 hover:bg-gray-500 text-gray-500 hover:text-gray-200 px-2 py-1 rounded-lg transition duration-200 cursor-default">7
                                days</span>
                        </div>
                        <div class="flex items-center justify-between mt-6">
                            <div>
                                <svg class="w-12 h-12 p-2.5 bg-green-400 bg-opacity-20 rounded-full text-green-600 border border-green-600"
                                    fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                        d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                                </svg>
                            </div>
                            <div class="flex flex-col">
                                <div class="flex items-end">
                                    <span class="text-2xl 2xl:text-3xl font-bold">217</span>
                                    <div class="flex items-center ml-2 mb-1">
                                        <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                                        </svg>
                                        <span class="font-bold text-sm text-gray-500 ml-0.5">5%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="px-6 py-6 bg-gray-100 border border-gray-300 rounded-lg shadow-xl">
                        <div class="flex items-center justify-between">
                            <span class="font-bold text-sm text-blue-600">New Connections</span>
                            <span
                                class="text-xs bg-gray-200 hover:bg-gray-500 text-gray-500 hover:text-gray-200 px-2 py-1 rounded-lg transition duration-200 cursor-default">7
                                days</span>
                        </div>
                        <div class="flex items-center justify-between mt-6">
                            <div>
                                <svg class="w-12 h-12 p-2.5 bg-blue-400 bg-opacity-20 rounded-full text-blue-600 border border-blue-600"
                                    fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1"
                                        d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                            </div>
                            <div class="flex flex-col">
                                <div class="flex items-end">
                                    <span class="text-2xl 2xl:text-3xl font-bold">54</span>
                                    <div class="flex items-center ml-2 mb-1">
                                        <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor"
                                            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
                                        </svg>
                                        <span class="font-bold text-sm text-gray-500 ml-0.5">7%</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="mt-4">
                    <canvas id="verticalBarChart"
                        style="display: block; box-sizing: border-box; height: 414px; width: 828px;" width="1656"
                        height="828"></canvas>
                </div>
            </div>
        </div>
    </div>
</template>


<style scoped></style>
