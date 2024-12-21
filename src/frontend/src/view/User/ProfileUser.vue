<script setup>
import { ref, onMounted, onBeforeMount, computed } from 'vue';
import Chart from 'chart.js/auto';

// Mở ô setting
const openSettings = ref(false)
const menu = ref(null)
const showChangePasswordModal = ref(false)
const currentPassword = ref('')
const newPassword = ref('')
const confirmPassword = ref('')

const toggleSettings = () => {
    openSettings.value = !openSettings.value
    console.log(openSettings.value)
}

const handleClickOutside = (event) => {
    if (menu.value && !menu.value.contains(event.target)) {
        openSettings.value = false
    }
    console.log(openSettings.value)
}

// Đổi avt

const selectFile = () => {
    const fileInput = document.querySelector('input[type="file"]');
    fileInput.click();
};

// Đổi mk
const changePassword = async () => {
    if (newPassword.value !== confirmPassword.value) {
        alert("Mật khẩu mới và xác nhận mật khẩu không khớp!");
        return;
    }

    try {
        const response = await fetch('/api/auth/change-password', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${localStorage.getItem('token')}` // Include token if needed
            },
            body: JSON.stringify({
                username: user.value.email, // Assuming username is the email
                currentPassword: currentPassword.value,
                newPassword: newPassword.value
            })
        });

        const data = await response.json();

        if (response.ok) {
            alert("Đổi mật khẩu thành công!");
            showChangePasswordModal.value = false;
        } else {
            alert(data.message || "Có lỗi xảy ra khi đổi mật khẩu.");
        }
    } catch (error) {
        console.error("Error changing password:", error);
        alert("Có lỗi xảy ra khi đổi mật khẩu.");
    }
};


const onFileChange = (event) => {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            user.value.profilePicture = e.target.result;
            alert("Đổi ảnh đại diện thành công!");
        };
        reader.readAsDataURL(file);
    }
};

const user = ref({
    firstname: "",
    lastname: "",
    birthdate: "",
    nationality: "",
    phoneNumber: "",
    email: "",
    dayAttemp: "",
    flightnum: "",
    countrynum: "",
    favplace: "",
    profilePicture: "https://vojislavd.com/ta-template-demo/assets/img/profile.jpg"
});


const fullname = computed(() => {
    return `${user.value.firstname} ${user.value.lastname}`.trim(); // Kết hợp họ và tên
});

// Dữ liệu lịch đặt vé
const flights = [
    { code: "VN123", destination: "Hà Nội", date: "2024-12-25", status: "Hoàn thành" },
    { code: "VN456", destination: "Đà Nẵng", date: "2024-12-28", status: "Chờ xử lý" },
    { code: "VN789", destination: "TP. Hồ Chí Minh", date: "2025-01-03", status: "Hủy" },
    { code: "VN321", destination: "Paris", date: "2025-01-05", status: "Hoàn thành" },
    { code: "VN654", destination: "New York", date: "2025-01-10", status: "Chờ xử lý" },
    { code: "VN987", destination: "Tokyo", date: "2025-01-15", status: "Hủy" },
    { code: "VN111", destination: "Singapore", date: "2025-01-20", status: "Hoàn thành" },
    { code: "VN222", destination: "Seoul", date: "2025-01-25", status: "Chờ xử lý" },
    { code: "VN333", destination: "Bangkok", date: "2025-01-30", status: "Hủy" },
    { code: "VN444", destination: "London", date: "2025-02-05", status: "Hoàn thành" },
];

const rowsPerPage = 5;
const currentPage = ref(1);

const totalPages = computed(() => Math.ceil(flights.length / rowsPerPage));

const totalFlights = flights.length;

const startFlight = computed(() => (currentPage.value - 1) * rowsPerPage + 1);
const endFlight = computed(() => Math.min(currentPage.value * rowsPerPage, totalFlights));

const paginatedFlights = computed(() => {
    const start = (currentPage.value - 1) * rowsPerPage;
    const end = start + rowsPerPage;
    return flights.slice(start, end);
});

function goToPage(page) {
    currentPage.value = page;
}

function prevPage() {
    if (currentPage.value > 1) {
        currentPage.value--;
    }
}

function nextPage() {
    if (currentPage.value < totalPages.value) {
        currentPage.value++;
    }
}

// Biểu đồ đặt vé trong năm
const DATA_SET_VERTICAL_BAR_CHART_1 = [1, 2, 0, 0, 3, 4, 1, 2, 0, 0, 0, 1];
const labels_vertical_bar_chart = ['January', 'February', 'Mart', 'April', 'May', 'Jun', 'July', 'August', 'September', 'October', 'November', 'December'];

const isEditing = ref(false);
const originalUserData = ref({});

const toggleEdit = () => {
    if (isEditing.value) {
        user.value = { ...originalUserData.value };
    } else {
        originalUserData.value = { ...user.value };
    }
    isEditing.value = !isEditing.value;
};

const countries = [
    "Afghanistan", "Albania", "Algeria", "Andorra", "Angola", "Antigua and Barbuda", "Argentina", "Armenia", "Australia", "Austria",
    "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bhutan",
    "Bolivia", "Bosnia and Herzegovina", "Botswana", "Brazil", "Brunei", "Bulgaria", "Burkina Faso", "Burundi", "Cabo Verde", "Cambodia",
    "Cameroon", "Canada", "Central African Republic", "Chad", "Chile", "China", "Colombia", "Comoros", "Congo", "Costa Rica",
    "Croatia", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "Ecuador", "Egypt",
    "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Eswatini", "Ethiopia", "Fiji", "Finland", "France", "Gabon",
    "Gambia", "Georgia", "Germany", "Ghana", "Greece", "Grenada", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana",
    "Haiti", "Honduras", "Hungary", "Iceland", "India", "Indonesia", "Iran", "Iraq", "Ireland", "Israel",
    "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Kuwait", "Kyrgyzstan", "Laos",
    "Latvia", "Lebanon", "Lesotho", "Liberia", "Libya", "Liechtenstein", "Lithuania", "Luxembourg", "Madagascar", "Malawi",
    "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Mauritania", "Mauritius", "Mexico", "Micronesia", "Moldova",
    "Monaco", "Mongolia", "Montenegro", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands",
    "New Zealand", "Nicaragua", "Niger", "Nigeria", "North Korea", "North Macedonia", "Norway", "Oman", "Pakistan", "Palau",
    "Palestine", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar", "Romania",
    "Russia", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal",
    "Serbia", "Seychelles", "Sierra Leone", "Singapore", "Slovakia", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Korea",
    "South Sudan", "Spain", "Sri Lanka", "Sudan", "Suriname", "Sweden", "Switzerland", "Syria", "Taiwan", "Tajikistan",
    "Tanzania", "Thailand", "Timor-Leste", "Togo", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Tuvalu",
    "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "Uruguay", "Uzbekistan", "Vanuatu", "Vatican City", "Venezuela",
    "Vietnam", "Yemen", "Zambia", "Zimbabwe"
];

const validateEmail = (email) => {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
};

const validatePhoneNumber = (phoneNumber) => {
    const re = /^\d{10,15}$/;
    return re.test(phoneNumber);
};

const saveChanges = async () => {
    if (!validateEmail(user.value.email)) {
        alert("Email không hợp lệ!");
        return;
    }

    if (!validatePhoneNumber(user.value.phoneNumber)) {
        alert("Số điện thoại không hợp lệ!");
        return;
    }

    try {
        const response = await fetch('/api/user/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${localStorage.getItem('token')}`
            },
            body: JSON.stringify(user.value)
        });

        if (response.ok) {
            alert("Cập nhật thông tin thành công!");
            isEditing.value = false;
        } else {
            alert("Có lỗi xảy ra khi cập nhật thông tin.");
        }
    } catch (error) {
        console.error("Error updating user info:", error);
        alert("Có lỗi xảy ra khi cập nhật thông tin.");
    }
};

onBeforeMount(async () => {
    try {
        const response = await fetch('http://localhost:8080/api/user/currentUser', {
            method: 'GET',
            headers: {
                Authorization: `Bearer ${localStorage.getItem('token')}`, // Include token if needed
            },
        });

        if (!response.ok) {
            throw new Error('Unauthorized');
        } else {
            const fetchedUser = await response.json();

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
    document.addEventListener('click', handleClickOutside);

    document.title = 'Trang cá nhân';
    const dataVerticalBarChart = {
        labels: labels_vertical_bar_chart,
        datasets: [
            {
                label: 'Số chuyến bay',
                data: DATA_SET_VERTICAL_BAR_CHART_1,
                borderColor: 'rgb(240, 165, 0)',
                backgroundColor: 'rgb(240, 165, 50)',
            }
        ]
    };

    const configVerticalBarChart = {
        type: 'bar',
        data: dataVerticalBarChart,
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Trong năm nay'
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
    <div class="h-full bg-gray-200 p-8">
        <div class="bg-white rounded-lg shadow-xl pb-8">
            <div class="absolute right-12 mt-4 rounded">
                <button @click.stop="toggleSettings"
                    class="border border-gray-400 p-2 rounded text-gray-300 hover:text-gray-300 bg-gray-100 bg-opacity-10 hover:bg-opacity-20"
                    title="Settings">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="currentColor" viewBox="0 0 24 24"
                        stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3"
                            d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a 1 1 0 110-2 1 1 0 010 2z">
                        </path>
                    </svg>
                </button>
                <div v-if="openSettings" ref="menu"
                    class="bg-white absolute right-0 w-40 py-2 mt-1 border border-gray-200 shadow-2xl">
                    <div class="pt-2">
                        <p class="text-gray-400 text-xs px-6 uppercase mb-1">Settings</p>
                        <button @click="showChangePasswordModal = true"
                            class="w-full flex items-center px-6 py-1.5 space-x-2 hover:bg-gray-200">
                            <span class="text-sm text-gray-700">Đổi mật khẩu</span>
                        </button>
                        <button @click="selectFile"
                            class="w-full flex items-center px-6 py-1.5 space-x-2 hover:bg-gray-200">
                            <span class="text-sm text-gray-700">Đổi ảnh đại diện</span>
                        </button>
                    </div>
                </div>
            </div>
            <div class="w-full h-[250px] overflow-hidden">

                <img :src="require('@/assets/background/profile_bg.jpg')"
                    class="w-full h-full rounded-tl-lg rounded-tr-lg object-cover">
            </div>
            <div class="flex flex-col items-center -mt-20">
                <img :src="user.profilePicture" class="w-40 h-40 border-4 border-white rounded-full object-cover">
                <input type="file" ref="fileInput" accept="image/*" @change="onFileChange" style="display: none;" />
                <div class="flex items-center space-x-2 mt-2">
                    <p class="text-2xl">{{ fullname }}</p>
                </div>
                <p class="text-sm text-gray-500">{{ user.nationality }}</p>
            </div>
        </div>

        <!-- Modal for changing password -->
        <div v-if="showChangePasswordModal"
            class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
            <div class="bg-white p-6 rounded-lg shadow-lg w-96">
                <h2 class="text-xl font-bold mb-4">Đổi mật khẩu</h2>
                <input type="password" v-model="currentPassword" placeholder="Mật khẩu hiện tại"
                    class="w-full p-2 border rounded mb-4">
                <input type="password" v-model="newPassword" placeholder="Mật khẩu mới"
                    class="w-full p-2 border rounded mb-4">
                <input type="password" v-model="confirmPassword" placeholder="Xác nhận mật khẩu"
                    class="w-full p-2 border rounded mb-4">
                <div class="flex justify-end">
                    <button @click="showChangePasswordModal = false"
                        class="px-4 py-2 bg-gray-300 rounded mr-2">Hủy</button>
                    <button @click="changePassword" class="px-4 py-2 bg-blue-500 text-white rounded">Xác nhận</button>
                </div>
            </div>
        </div>

        <div class="my-4 flex flex-col 2xl:flex-row space-y-4 2xl:space-y-0 2xl:space-x-4">
            <div class="w-full flex flex-col 2xl:w-1/3">
                <div class="flex-1 bg-white rounded-lg shadow-xl p-8">
                    <div class="flex justify-between items-center">
                        <h4 class="text-xl text-gray-900 font-bold">Thông tin cá nhân</h4>
                        <div v-if="isEditing" class="flex space-x-2">
                            <button @click="toggleEdit"
                                class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600 transition duration-300">Hủy</button>
                            <button @click="saveChanges"
                                class="px-4 py-2 bg-green-500 text-white rounded hover:bg-green-600 transition duration-300">Lưu</button>
                        </div>
                        <button v-else @click="toggleEdit" class="text-gray-500 hover:text-gray-700">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24"
                                stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M15.232 5.232l3.536 3.536M9 11l3 3L20.768 5.232a2.5 2.5 0 00-3.536-3.536L9 11z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M6 18v-3a2 2 0 012-2h3" />
                            </svg>
                        </button>
                    </div>
                    <ul class="mt-7 text-gray-700">
                        <li class="flex border-y py-2">
                            <span class="font-bold w-24">Họ và tên:</span>
                            <span v-if="!isEditing">{{ fullname }}</span>
                            <div v-else>
                                <input v-model="user.firstname" class="border rounded p-1" />
                                <input v-model="user.lastname" class="border rounded p-1 ml-2" />
                            </div>
                        </li>
                        <li class="flex border-b py-2">
                            <span class="font-bold w-24">Ngày sinh:</span>
                            <span v-if="!isEditing">{{ user.birthdate }}</span>
                            <input v-else v-model="user.birthdate" type="date" class="border rounded p-1" />
                        </li>
                        <li class="flex border-b py-2">
                            <span class="font-bold w-24">Số di động:</span>
                            <span v-if="!isEditing">{{ user.phoneNumber }}</span>
                            <input v-else v-model="user.phoneNumber" class="border rounded p-1" />
                        </li>
                        <li class="flex border-b py-2">
                            <span class="font-bold w-24">Email:</span>
                            <span v-if="!isEditing">{{ user.email }}</span>
                            <input v-else v-model="user.email" type="email" class="border rounded p-1" />
                        </li>
                        <li class="flex border-b py-2">
                            <span class="font-bold w-24">Quốc tịch:</span>
                            <span v-if="!isEditing">{{ user.nationality }}</span>
                            <select v-else v-model="user.nationality" class="border rounded p-1">
                                <option v-for="country in countries" :key="country" :value="country">{{ country }}
                                </option>
                            </select>
                        </li>
                    </ul>
                </div>
                <div class="flex-1 bg-white rounded-lg shadow-xl mt-4 p-8">
                    <h4 class="text-xl text-gray-900 font-bold">Lịch sử đặt vé</h4>
                    <div class="mt-2 relative overflow-x-auto sm:rounded-lg">
                        <table
                            class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400 table-fixed">
                            <thead
                                class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                                <tr>
                                    <th scope="col" class="px-6 py-3 w-1/3">
                                        Mã chuyến
                                    </th>
                                    <th scope="col" class="px-6 py-3 w-1/3">
                                        Điểm đến
                                    </th>
                                    <th scope="col" class="px-6 py-3 w-1/3">
                                        Ngày khởi hành
                                    </th>
                                    <th scope="col" class="px-6 py-3 w-1/3">
                                        Trạng thái
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="flight in paginatedFlights" :key="flight.code"
                                    class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600">
                                    <td scope="row" class="px-4 py-2 w-1/3">{{ flight.code }}</td>
                                    <td class="px-6 py-2 w-1/3">{{ flight.destination }}
                                    </td>
                                    <td class="px-4 py-2 w-1/3">{{ flight.date }}</td>
                                    <td
                                        class="px-6 py-4 w-1/3 whitespace-no-wrap text-blue-900 border-gray-500 text-sm leading-5 text-center">
                                        <span :class="{
                                            'text-green-900': flight.status === 'Hoàn thành',
                                            'text-yellow-700': flight.status === 'Chờ xử lý',
                                            'text-red-900': flight.status === 'Hủy',
                                        }" class="relative inline-block px-3 py-1 font-semibold leading-tight">
                                            <span aria-hidden :class="{
                                                'bg-green-200': flight.status === 'Hoàn thành',
                                                'bg-yellow-50': flight.status === 'Chờ xử lý',
                                                'bg-red-200': flight.status === 'Hủy',
                                            }" class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                            <span class="relative text-xs">{{ flight.status }}</span>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <nav class="flex items-center flex-column flex-wrap md:flex-row justify-between pt-4"
                            aria-label="Table navigation">
                            <span
                                class="text-sm font-normal text-gray-500 dark:text-gray-400 mb-4 md:mb-0 block w-full md:inline md:w-auto">
                                Hiển thị
                                <span class="font-semibold text-gray-600 dark:text-white">{{ startFlight }}</span> -
                                <span class="font-semibold text-gray-600 dark:text-white">{{ endFlight }}</span>
                                của
                                <span class="font-semibold text-gray-600 dark:text-white">{{ totalFlights }}</span>
                            </span>
                            <ul class="inline-flex -space-x-px rtl:space-x-reverse text-sm h-8">
                                <li>
                                    <button @click="prevPage"
                                        class="flex items-center justify-center px-3 h-8 ms-0 leading-tight text-gray-500 bg-white border border-gray-300 rounded-s-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">Previous</button>
                                </li>
                                <li v-for="page in totalPages" :key="page">
                                    <button @click="goToPage(page)"
                                        class="flex items-center justify-center px-3 h-8 leading-tight text-gray-500 bg-white border border-gray-300 hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">{{
                                            page }}</button>
                                </li>
                                <li>
                                    <button @click="nextPage"
                                        class="flex items-center justify-center px-3 h-8 leading-tight text-gray-500 bg-white border border-gray-300 rounded-e-lg hover:bg-gray-100 hover:text-gray-700 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">Next</button>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="flex flex-col w-full 2xl:w-2/3">
                <div class="flex-1 bg-white rounded-lg shadow-xl p-8">
                    <h4 class="text-xl text-gray-900 font-bold">Thống kê</h4>

                    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mt-4">
                        <div class="px-6 py-6 bg-gray-100 border border-gray-300 rounded-lg shadow-xl">
                            <div class="flex items-center justify-between">
                                <span class="font-bold text-sm text-indigo-600">Số chuyến bay đã đi</span>
                            </div>
                            <div class="flex items-center justify-between mt-6">
                                <div>
                                    <svg class="w-12 h-12 p-2.5 bg-indigo-400 bg-opacity-20 rounded-full text-indigo-600 border border-indigo-600"
                                        fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M10.18 9l-2.36 5.09a.75.75 0 00.7 1.09h7.28a.75.75 0 00.7-1.09L13.82 9m-3.64 0L8.5 5.5m3.68 3.5L15.5 5.5m-7 12h7" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 14.5v5" />
                                    </svg>

                                </div>
                                <div class="flex flex-col">
                                    <div class="flex items-end">
                                        <span class="text-2xl 2xl:text-3xl font-bold">{{ user.flightnum }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="px-6 py-6 bg-gray-100 border border-gray-300 rounded-lg shadow-xl">
                            <div class="flex items-center justify-between">
                                <span class="font-bold text-sm text-green-600">Số nước đã tới</span>
                            </div>
                            <div class="flex items-center justify-between mt-6">
                                <div>
                                    <svg class="w-12 h-12 p-2.5 bg-green-400 bg-opacity-20 rounded-full text-green-600 border border-green-600"
                                        fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M3.172 11.172a4 4 0 015.656 0L12 14.344l3.172-3.172a4 4 0 115.656 5.656l-4 4a4 4 0 01-5.656 0l-4-4a4 4 0 010-5.656z">
                                        </path>
                                    </svg>
                                </div>
                                <div class="flex flex-col">
                                    <div class="flex items-end">
                                        <span class="text-2xl 2xl:text-3xl font-bold">{{ user.countrynum }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="px-6 py-6 bg-gray-100 border border-gray-300 rounded-lg shadow-xl">
                            <div class="flex items-center justify-between">
                                <span class="font-bold text-sm text-blue-600">Địa điểm du lịch ưa thích</span>
                            </div>
                            <div class="flex items-center justify-between mt-6">
                                <div>
                                    <svg class="w-12 h-12 p-2.5 bg-blue-400 bg-opacity-20 rounded-full text-blue-600 border border-blue-600"
                                        fill="none" stroke="currentColor" viewBox="0 0 24 24"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 11c1.93 0 3.679.784 5.012 2.075M12 11C10.071 9.784 8.321 9 6.988 9m5.012 2c.87.87 1.658 2.137 1.658 3.586 0 1.45-.788 2.716-1.658 3.586M12 11v3.586m0 0v1.828m0-1.828c-.87.87-1.658 2.137-1.658 3.586 0 1.45.788 2.716 1.658 3.586">
                                        </path>
                                    </svg>
                                </div>
                                <div class="flex flex-col">
                                    <div class="flex items-end">
                                        <span class="text-2xl 2xl:text-3xl font-bold">{{ user.favplace }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <canvas id="verticalBarChart" class="w-full h-auto"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped></style>
