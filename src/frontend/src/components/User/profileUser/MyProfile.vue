<script setup>
import {ref, onBeforeMount} from 'vue';

import ChangePassword from "@/components/User/profileUser/ChangePassword.vue";

// Define the component state variables
const isEditingProfile = ref(false);
const isEditingLoginDetails = ref(false);
const isChangePasswordVisible = ref(false);

const loginDetails = ref({
  phoneNumber: "",
  email: "",
  password: "",
});
const user = ref({
  firstname: "",
  lastname: "",
  birthdate: "",
  nationality: "",
  phoneNumber: "",
  email: "",
  password: ""
});

// Methods
const toggleEditProfile = () => {
  if (isEditingProfile.value) {
    updateProfile();
  }
  isEditingProfile.value = !isEditingProfile.value;
};

const toggleEditLoginDetails = () => {
  if (isEditingLoginDetails.value) {
    updateProfile();
  }
  isEditingLoginDetails.value = !isEditingLoginDetails.value;
};

const updateProfile = async () => {
  // const store = profileStore();
  // try {
  //   const response = await fetch("/api/user/updateUser", {
  //     method: "PUT",
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: JSON.stringify({
  //       firstname: profileData.value.firstname,
  //       lastname: profileData.value.lastname,
  //       birthdate: profileData.value.birthdate,
  //       phoneNumber: loginDetails.value.phoneNumber,
  //       email: loginDetails.value.email,
  //     }),
  //   });
  //
  //   if (!response.ok) {
  //     throw new Error("Cập nhật thất bại");
  //   }
  //
  //   const updatedUser = await response.json();
  //   store.saveUser(updatedUser);
  //   alert("Cập nhật thông tin cá nhân thành công!");
  // } catch (error) {
  //   console.error(error);
  //   alert("Cập nhật thông tin cá nhân thất bại!");
  // }
};

const showChangePassword = () => {
  isChangePasswordVisible.value = true;
};

const closeChangePassword = () => {
  isChangePasswordVisible.value = false;
};

// Mounted lifecycle hook
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
        password: '', // Mật khẩu có thể không cần thiết hiển thị
      };


    }
  } catch (error) {
    console.error('Error fetching user data:', error);
  }
});
</script>

<template>
  <!-- Template remains the same as in the original code -->
  <div class="text-center my-5">
<!--    <div>{{user.firstname}}</div>-->
    <h1 class="text-3xl text-orange-500 font-bold">Hồ sơ cá nhân</h1>
  </div>
  <div class="max-w-4xl mx-auto bg-white p-6 rounded-lg shadow-md border border-orange-100">

    <!-- Profile Section -->
    <div class="mb-8">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-xl font-semibold text-orange-600">Thông tin cá nhân</h3>
        <button
            class="px-4 py-2 bg-orange-500 font-semibold text-white rounded-lg hover:bg-orange-600 focus:ring-2 focus:ring-orange-400"
            @click="toggleEditProfile"
        >
          {{ isEditingProfile ? "Lưu" : "Sửa" }}
        </button>
      </div>
      <div class="space-y-6">
        <!-- Họ và Tên -->
        <div class="flex items-center space-x-4">
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Họ</label>
            <input
                v-if="isEditingProfile"
                type="text"
                v-model="user.firstname"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Họ</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ user.firstname }}</span>
          </div>
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Tên</label>
            <input
                v-if="isEditingProfile"
                type="text"
                v-model="user.lastname"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Tên</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ user.lastname }}</span>
          </div>
        </div>

        <!-- Ngày sinh và Quốc tịch -->
        <div class="flex items-center space-x-4">
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Ngày sinh</label>
            <input
                v-if="isEditingProfile"
                type="date"
                v-model="user.birthdate"
                class="w-1/2 px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Ngày sinh</label>
            <span class="w-1/2 px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ user.birthdate }}</span>
          </div>
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Quốc tịch</label>
            <select
                v-if="isEditingProfile"
                v-model="user.nationality"
                class="w-1/2 px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            >
              <option>Việt Nam</option>
            </select>
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Quốc tịch</label>
            <span class="w-1/2 px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ user.nationality }}</span>
          </div>
        </div>

      </div>
    </div>

    <!-- Login Details Section -->
    <div class="mb-8">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-semibold text-orange-600">Thông tin đăng nhập</h3>
        <button
            class="px-4 py-2 bg-orange-500 font-semibold text-white rounded-lg hover:bg-orange-600 focus:ring-2 focus:ring-orange-400"
            @click="toggleEditLoginDetails"
        >
          {{ isEditingLoginDetails ? "Lưu" : "Sửa" }}
        </button>
      </div>
      <div class="space-y-6">
        <!-- SĐT -->
        <div class="flex items-center space-x-4">
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Số điện thoại</label>
            <input
                v-if="isEditingProfile"
                type="text"
                v-model="loginDetails.phoneNumber"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Số điện thoại</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ user.phoneNumber }}</span>
          </div>
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Email</label>
            <input
                v-if="isEditingProfile"
                type="email"
                v-model="user.email"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Email</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ user.email }}</span>
          </div>
        </div>

        <!-- Mật khẩu -->
        <div class="flex flex-col">
          <label class="font-semibold text-orange-700 text-left">Mật khẩu</label>
          <div class="flex-1 flex space-x-4 w-1/2">

            <button
                class="w-1/3  py-2 bg-orange-100 font-semibold text-orange-800 rounded-lg hover:bg-orange-200"
                @click="showChangePassword"
            >
              Đổi mật khẩu
            </button>
          </div>
        </div>

        <!-- Pop-up ChangePassword -->
        <div
            v-if="isChangePasswordVisible"
            class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50"
        >
          <!-- Hộp pop-up -->
          <div class="bg-white w-full max-w-md p-6 rounded-lg shadow-lg">
            <ChangePassword @close="closeChangePassword" />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>