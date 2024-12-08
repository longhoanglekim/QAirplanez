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
      alert("Mật khẩu đã được lưu!");
      this.$emit("close");
    },
  },
};
</script>

<template>
  <div>
    <h1 class="text-xl font-bold mb-4 text-orange-500">Đổi mật khẩu</h1>
    <div class="space-y-4">
      <!-- Mật khẩu hiện tại -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Mật khẩu hiện tại
        </label>
        <input
            type="password"
            v-model="currentPassword"
            class="w-full px-4 py-2 border border-orange-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
        />
      </div>
      <!-- Mật khẩu mới -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Mật khẩu mới
        </label>
        <input
            type="password"
            v-model="newPassword"
            class="w-full px-4 py-2 border border-orange-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
        />
      </div>
      <!-- Nhập lại mật khẩu mới -->
      <div>
        <label class="block text-sm font-medium text-gray-700 mb-1">
          Nhập lại mật khẩu mới
        </label>
        <input
            type="password"
            v-model="confirmNewPassword"
            class="w-full px-4 py-2 border border-orange-300 rounded-lg shadow-sm focus:ring-orange-500 focus:border-orange-500"
        />
      </div>
    </div>
    <!-- Nút hành động -->
    <div class="flex justify-end space-x-4 mt-6">
      <button
          @click="$emit('close')"
          class="px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300"
      >
        Hủy
      </button>
      <button
          @click="savePassword"
          class="px-4 py-2 bg-orange-500 text-white rounded-lg hover:bg-orange-600"
      >
        Lưu
      </button>
    </div>
  </div>
</template>

<style scoped>
</style>
