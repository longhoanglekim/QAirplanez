<script>
export default {
  name: "ChangePassword",
  data() {
    return {
      currentPassword: "",
      newPassword: "",
      confirmNewPassword: "",
      error: "",
    };
  },
  methods: {
    savePassword() {
      if (this.newPassword !== this.confirmNewPassword) {
        this.error = "Mật khẩu mới không khớp!";
        return;
      }
      console.log("Mật khẩu mới đã được lưu:", this.newPassword);

      this.$router.push({ name: "MyProfile" });
    },
  },
};
</script>

<template>
  <div class="change-password-container">
    <h1>Đổi mật khẩu</h1>
    <div class="form">
      <!-- Mật khẩu hiện tại -->
      <div class="form-group">
        <label for="current-password">Mật khẩu hiện tại</label>
        <input
            type="password"
            id="current-password"
            v-model="currentPassword"
        />
      </div>

      <!-- Mật khẩu mới -->
      <div class="form-group">
        <label for="new-password">Mật khẩu mới</label>
        <input
            type="password"
            id="new-password"
            v-model="newPassword"
        />
      </div>

      <!-- Nhập lại mật khẩu mới -->
      <div class="form-group">
        <label for="confirm-new-password">Nhập lại mật khẩu mới</label>
        <input
            type="password"
            id="confirm-new-password"
            v-model="confirmNewPassword"
        />
      </div>

      <!-- Thông báo lỗi -->
      <div v-if="error" class="error">{{ error }}</div>

      <!-- Nút hành động -->
      <div class="actions">
        <button @click="$router.push({ name: 'MyProfile' })">Hủy</button>
        <button @click="savePassword">Lưu</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.change-password-container {
  max-width: 400px;
  margin: 0 auto;
  padding: 1rem;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-group {
  margin-bottom: 1rem;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

input {
  width: 100%;
  padding: 0.5rem;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.error {
  color: red;
  margin-bottom: 1rem;
}

.actions {
  display: flex;
  justify-content: space-between;
}
</style>
