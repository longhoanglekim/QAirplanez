<script>
export default {
  name: "MyProfile",
  data() {
    return {
      isEditingProfile: false,
      isEditingLoginDetails: false,
      profileData: {
        name: "Lương Thế Quyền",
        birthday: "03/02/2004",
        gender: "Nam",
        nationality: "Việt Nam",
      },
      // Dữ liệu của login details
      loginDetails: {
        mobileNumber: "0986405165",
        email: "hehe@gmail.com",
        password: "luongthequyen",
      },
    };
  },
  methods: {
    toggleEditProfile() {
      this.isEditingProfile = !this.isEditingProfile;
    },
    toggleEditLoginDetails() {
      this.isEditingLoginDetails = !this.isEditingLoginDetails;
    },
    getMaskedPassword() {
      return "*".repeat(this.loginDetails.password.length);
    },
    navigateToChangePassword() {
      this.$router.push({name: "ChangePassword"});
    }
  },
};
</script>

<template>
  <div class="profile-container">
    <h1>My Profile</h1>

    <!-- Profile Section -->
    <div class="profile-section">
      <div class="header">
        <h3>Thông tin cá nhân</h3>
        <button class="edit-btn" @click="toggleEditProfile">
          {{ isEditingProfile ? "Lưu" : "Sửa" }}
        </button>
      </div>
      <div class="details">
        <div class="row" v-if="isEditingProfile">
          <span class="label">Họ và tên</span>
          <input type="text" v-model="profileData.name" class="value-input" />
        </div>
        <div class="row" v-if="!isEditingProfile">
          <span class="label">Họ và tên</span>
          <span class="value">{{ profileData.name }}</span>
        </div>
        <div class="row" v-if="isEditingProfile">
          <span class="label">Ngày sinh</span>
          <input type="date" v-model="profileData.birthday" class="value-input" />
        </div>
        <div class="row" v-if="!isEditingProfile">
          <span class="label">Ngày sinh</span>
          <span class="value">{{ profileData.birthday }}</span>
        </div>
        <div class="row" v-if="isEditingProfile">
          <span class="label">Giới tính</span>
          <select v-model="profileData.gender" class="value-input">
            <option>Nam</option>
            <option>Nữ</option>
            <option>Khác</option>
          </select>
        </div>
        <div class="row" v-if="!isEditingProfile">
          <span class="label">Giới tính</span>
          <span class="value">{{ profileData.gender }}</span>
        </div>
        <div class="row" v-if="isEditingProfile">
          <span class="label">Quốc tịch</span>
          <select v-model="profileData.nationality" class="value-input">
            <option>Việt Nam</option>
          </select>
        </div>
        <div class="row" v-if="!isEditingProfile">
          <span class="label">Quốc tịch</span>
          <span class="value">{{ profileData.nationality }}</span>
        </div>
      </div>
    </div>

    <!-- Login Details Section -->
    <div class="login-details-section">
      <div class="header">
        <h3>Thông tin đăng nhập</h3>
        <button class="edit-btn" @click="toggleEditLoginDetails">
          {{ isEditingLoginDetails ? "Lưu" : "Sửa" }}
        </button>
      </div>
      <div class="details">
        <div class="row" v-if="isEditingLoginDetails">
          <span class="label">SĐT</span>
          <input
              type="text"
              v-model="loginDetails.mobileNumber"
              class="value-input"
          />
        </div>
        <div class="row" v-if="!isEditingLoginDetails">
          <span class="label">SĐT</span>
          <span class="value">{{ loginDetails.mobileNumber }}</span>
        </div>
        <div class="row" v-if="isEditingLoginDetails">
          <span class="label">Email</span>
          <input type="email" v-model="loginDetails.email" class="value-input" />
        </div>
        <div class="row" v-if="!isEditingLoginDetails">
          <span class="label">Email</span>
          <span class="value">{{ loginDetails.email }}</span>
        </div>
        <div class="row">
          <span class="label">Mật khẩu</span>
          <span class="value">
            {{ getMaskedPassword() }}
            <button class="change-password-btn" @click="navigateToChangePassword">
              Đổi mật khẩu
            </button>
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.profile-container {
  display: flex;
  flex-direction: column;
  gap: 2rem;
  padding: 1.5rem;
  font-family: Arial, sans-serif;
}

/* Section Styling */
.profile-section,
.login-details-section {
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 1rem;
  background-color: #fff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #ddd;
  padding-bottom: 0.5rem;
  margin-bottom: 1rem;
}

.edit-btn {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: background-color 0.3s;
}

.edit-btn:hover {
  background-color: #0056b3;
}

/* Details Section */
.details .row {
  display: flex;
  justify-content: space-between;
  padding: 0.5rem 0;
  border-bottom: 1px solid #f4f4f4;
}

.details .row:last-child {
  border-bottom: none;
}

.label {
  font-weight: bold;
  color: #333;
}

.value {
  color: #666;
}

.value-input {
  border: 1px solid #ddd;
  padding: 0.3rem;
  border-radius: 4px;
  font-size: 0.9rem;
  width: 60%;
}

.value-input:focus {
  border-color: #007bff;
  outline: none;
}

/* Thêm nút Đổi mật khẩu */
.change-password-btn {
  background: none;
  border: none;
  color: #007bff;
  cursor: pointer;
  margin-left: 10px;
  text-decoration: underline;
  font-size: 0.9rem;
}

.change-password-btn:hover {
  text-decoration: none;
  color: #0056b3;
}
</style>
