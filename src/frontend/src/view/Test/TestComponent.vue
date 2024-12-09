<template>
<<<<<<< HEAD
  <div>

  </div>
</template>

<script setup>

</script>

<style lang="scss" scoped>

</style>
=======
  <div class="flex justify-center items-center h-screen bg-gray-100">
    <div class="w-full max-w-sm p-8 bg-white shadow-lg rounded-lg">
      <h2 class="text-2xl font-semibold text-center mb-4">Upload Avatar</h2>

      <form enctype="multipart/form-data" @submit.prevent="uploadImage">
        <div class="mb-4">
          <input type="file" @change="handleFileChange" class="w-full p-2 border rounded-md" accept="image/*" />
        </div>

        <button
            type="submit"
            :disabled="!selectedImage"
            class="w-full py-2 px-4 bg-blue-500 text-white rounded-md disabled:bg-gray-400"
        >
          Upload Image
        </button>
      </form>

      <p v-if="uploadStatus" class="mt-4 text-center" :class="statusClass">{{ uploadStatus }}</p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      selectedImage: null,
      uploadStatus: '',
      statusClass: ''
    };
  },
  methods: {
    handleFileChange(event) {
      this.selectedImage = event.target.files[0];
    },

    async uploadImage() {
      if (!this.selectedImage) {
        this.uploadStatus = 'Please select an image';
        this.statusClass = 'text-red-500';
        return;
      }

      const formData = new FormData();
      formData.append('image', this.selectedImage);

      try {
        const response = await fetch('http://localhost:8080/api/user/setAvatar', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
          },
          body: formData,
        });

        if (!response.ok) {
          throw new Error('Upload failed');
        }

        const data = await response.json(); // Giả sử API trả về thông báo dạng JSON
        this.uploadStatus = data.message || 'Set Avatar thành công';
        this.statusClass = 'text-green-500';
      } catch (error) {
        this.uploadStatus = error.message || 'Upload failed';
        this.statusClass = 'text-red-500';
      }
    }
  }
};
</script>

<style scoped>
/* Optional: Add custom styling if needed */
</style>
>>>>>>> b157bdff30b3a973148760f8bf1ea81045339bd6
