<script>
import { profileStore } from "@/store/account";
import ChangePassword from "@/components/User/profileUser/ChangePassword.vue"

export default {
  name: "MyProfile",
  components: {ChangePassword},
  data() {
    return {
      isEditingProfile: false,
      isEditingLoginDetails: false,
      profileData: {
        firstname: "Lương Thế",
        lastname: "Quyền",
        birthdate: "03/02/2004",
        nationality: "Việt Nam",
      },
      loginDetails: {
        phoneNumber: "0986405165",
        email: "hehe@gmail.com",
        password: "luongthequyen",
      },
      isChangePasswordVisible: false,
    };
  },
  methods: {
    toggleEditProfile() {
      if (this.isEditingProfile) {
        this.updateProfile();
      }
      this.isEditingProfile = !this.isEditingProfile;
    },
    toggleEditLoginDetails() {
      if (this.isEditingLoginDetails) {
        this.updateProfile();
      }
      this.isEditingLoginDetails = !this.isEditingLoginDetails;
    },
    getMaskedPassword() {
      return "*".repeat(this.loginDetails.password.length);
    },
    async updateProfile() {
      const store = profileStore();
      try {
        const response = await fetch("/api/user/updateUser", {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({
            firstname: this.profileData.firstname,
            lastname: this.profileData.lastname,
            birthdate: this.profileData.birthdate,
            phoneNumber: this.loginDetails.phoneNumber,
            email: this.loginDetails.email,
          }),
        });

        if (!response.ok) {
          throw new Error("Cập nhật thất bại");
        }

        const updatedUser = await response.json();
        store.saveUser(updatedUser);
        alert("Cập nhật thông tin cá nhân thành công!");
      } catch (error) {
        console.error(error);
        alert("Cập nhật thông tin cá nhân thất bại!");
      }
    },
    showChangePassword() {
      this.isChangePasswordVisible = true; // Hiển thị pop-up
    },
    closeChangePassword() {
      this.isChangePasswordVisible = false; // Đóng pop-up
    },
  },
  /*
  mounted() {
    const store = profileStore();

    fetch("/api/user/currentUser")
        .then((response) => {
          if (!response.ok) {
            throw new Error("Không thể tải dữ liệu người dùng");
          }
          return response.json();
        })
        .then((user) => {
          store.saveUser(user);
          this.profileData.firstname = user.firstname;
          this.profileData.lastname = user.lastname;
          this.profileData.birthdate = user.birthdate;
          this.loginDetails.phoneNumber = user.phoneNumber;
          this.loginDetails.email = user.email;
        })
        .catch((error) => {
          console.error(error);
          alert("Không thể tải thông tin người dùng");
        });
  }
*/
};
</script>

<template>
  <div class="text-center my-5">
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
                v-model="profileData.firstname"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Họ</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ profileData.firstname }}</span>
          </div>
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Tên</label>
            <input
                v-if="isEditingProfile"
                type="text"
                v-model="profileData.lastname"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Tên</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ profileData.lastname }}</span>
          </div>
        </div>

        <!-- Ngày sinh và Quốc tịch -->
        <div class="flex items-center space-x-4">
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Ngày sinh</label>
            <input
                v-if="isEditingProfile"
                type="date"
                v-model="profileData.birthdate"
                class="w-1/2 px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Ngày sinh</label>
            <span class="w-1/2 px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ profileData.birthdate }}</span>
          </div>
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Quốc tịch</label>
            <select
                v-if="isEditingProfile"
                v-model="profileData.nationality"
                class="w-1/2 px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            >
              <option>Việt Nam</option>
            </select>
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Quốc tịch</label>
            <span class="w-1/2 px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ profileData.nationality }}</span>
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
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ loginDetails.phoneNumber }}</span>
          </div>
          <div v-if="isEditingProfile" class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Email</label>
            <input
                v-if="isEditingProfile"
                type="email"
                v-model="loginDetails.email"
                class="px-2 py-3 border border-orange-200 rounded-xl focus:border-orange-500 focus:ring-orange-500"
            />
          </div>
          <div v-else class="flex flex-col w-1/2">
            <label class="font-semibold text-orange-700 text-left">Email</label>
            <span class="px-2 py-3 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ loginDetails.email }}</span>
          </div>
        </div>

        <!-- Mật khẩu -->
        <div class="flex flex-col">
          <label class="font-semibold text-orange-700 text-left">Mật khẩu</label>
          <div class="flex-1 flex space-x-4 w-1/2">
            <span class="w-2/3 px-2 py-2 border border-orange-200 bg-orange-50 rounded-xl block text-orange-800 text-left cursor-default">{{ getMaskedPassword() }}</span>
            <button
                class="w-1/3 ml-2.5 px-1 py-2 bg-orange-100 font-semibold text-orange-800 rounded-lg hover:bg-orange-200"
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
