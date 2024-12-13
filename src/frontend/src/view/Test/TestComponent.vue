<template>
  <div class="flex justify-center items-center h-screen bg-gray-100">
    <div class="w-full max-w-lg p-8 bg-white shadow-lg rounded-lg">
      <h2 class="text-2xl font-semibold text-center mb-4">View Image</h2>

      <!-- Hiển thị ảnh khi đã tải -->
      <div v-if="imageData">
        <img :src="imageData" alt="Image" class="w-full h-auto rounded-lg" />
      </div>

      <!-- Thông báo lỗi nếu có -->
      <p v-else-if="uploadStatus" class="mt-4 text-center" :class="statusClass">{{ uploadStatus }}</p>
    </div>
    <div>
      <p>Taken from wikpedia</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      imageData: null, // Dữ liệu base64 của ảnh
      uploadStatus: '', // Trạng thái tải ảnh
      statusClass: '' // Lớp CSS để thông báo trạng thái (thành công hoặc thất bại)
    };
  },
  mounted() {
    this.fetchImage();
  },
  methods: {
    // Phương thức lấy ảnh từ API và chuyển thành base64
    async fetchImage() {
      try {
        // Gửi request để lấy ảnh từ server (API trả về base64)
        const response = await fetch('http://localhost:8080/api/user/getAvatar', {
          method: 'POST',
          headers: {
            Authorization : `Bearer ${localStorage.getItem('token')}` // Thêm token nếu cần
          }
        });

        // Nếu request thất bại
        if (!response.ok) {
          throw new Error('Unable to fetch image');
        }

        const data = await response.json(); // Giả sử API trả về dữ liệu có trường 'image' chứa base64
        this.imageData = data.imageUrl ? `${data.imageUrl}` : ''; // Nếu có dữ liệu, gán vào imageData
        this.uploadStatus = 'Image loaded successfully!';
        this.statusClass = 'text-green-500';
      } catch (error) {
        this.uploadStatus = error.message || 'Failed to load image';
        this.statusClass = 'text-red-500';
      }
    }
  }
};
</script>

<style scoped>
/* Optional: Add custom styling for your image display */
</style>
