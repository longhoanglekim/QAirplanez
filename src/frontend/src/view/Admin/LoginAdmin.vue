<template>
  <div class="h-screen bg-cover bg-center flex items-center justify-center" :style="{ backgroundImage: 'url(/path/to/your-image.jpg)' }">
    <div class="bg-white p-8 rounded-lg shadow-lg w-96">
      <h2 class="text-2xl font-semibold text-center text-blue-600 mb-6">Đăng Nhập</h2>
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
      password: ''
    };
  },
  methods: {
    handleSubmit() {
      console.log('Tên đăng nhập:', this.username);
      console.log('Mật khẩu:', this.password);
      
    }
  }
}
</script>

<style scoped>
/* Bạn có thể thêm các kiểu CSS tùy chỉnh nếu cần */
</style>
