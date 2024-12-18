<template>
  <div class="h-screen bg-cover bg-center flex items-center justify-center" :style="{ backgroundImage: 'url(/path/to/your-image.jpg)' }">
    <div class="bg-white p-8 rounded-lg shadow-lg w-96">
      <h2 class="text-2xl font-semibold text-center text-blue-600 mb-6">Đăng Nhập Admin</h2>
      <form @submit.prevent="handleSubmit">
        <div class="mb-4">
          <label for="username" class="block text-gray-700">Tên đăng nhập</label>
          <input 
            type="text" 
            id="username" 
            v-model="username" 
            required 
            class="w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" />
        </div>
        <div class="mb-6">
          <label for="password" class="block text-gray-700">Mật khẩu</label>
          <input 
            type="password" 
            id="password" 
            v-model="password" 
            required 
            class="w-full px-4 py-2 mt-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" />
        </div>
        <div v-if="error" class="mb-4 text-red-500 text-sm text-center">
          {{ error }}
        </div>
        <button type="submit" class="w-full py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-600">
          Đăng Nhập
        </button>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      username: '',
      password: '',
      error: ''
    };
  },
  methods: {
    async handleSubmit() {
      try {
        const response = await fetch("http://localhost:8080/api/auth/admin/login", {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            username: this.username,
            password: this.password
          })
        });
        const data = await response.json();

        if (response.ok) {
          // Store the admin token
          localStorage.setItem('adminToken', data.token);
          // Clear any existing error
          this.error = '';
          // Redirect to admin dashboard
          this.$router.push('/admin/dashboard');
        } else {
          // Display error message from server
          this.error = data.error || 'Đăng nhập thất bại';
        }
      } catch (error) {
        console.error('Error:', error);
        this.error = 'Đã xảy ra lỗi khi đăng nhập';
      }
    }
  }
}
</script>

<style scoped>
/* Bạn có thể thêm các kiểu CSS tùy chỉnh nếu cần */
</style>
