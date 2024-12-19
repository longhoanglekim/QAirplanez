<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center text-left">
    <div class="bg-white p-4 rounded-md w-1/2">
      <h1 class="text-2xl font-bold text-center">Chỉnh sửa tin tức</h1>
      <div class="flex flex-col gap-2 mb-4">
        <label for="title" class="pl-2">Tiêu đề</label>
        <input
            type="text"
            id="title"
            class="border border-slate-300 rounded-md p-2"
            v-model="newsData.title"
            :placeholder="props.news.title || 'Nhập tiêu đề mới'"
        >
      </div>
      <div class="flex flex-col gap-2 mb-4">
        <label for="content" class="pl-2">Nội dung</label>
        <textarea
            id="content"
            class="border border-slate-300 rounded-md p-2 resize-none"
            rows="4"
            v-model="newsData.content"
            :placeholder="props.news.content || 'Nhập nội dung mới'"
        ></textarea>
      </div>
      <div class="flex flex-col gap-2 mb-4">
        <label for="postingDate" class="pl-2">Ngày đăng</label>
        <input
            type="datetime-local"
            id="postingDate"
            class="border border-slate-300 rounded-md p-2"
            v-model="newsData.postingDate"
        >
      </div>
      <div class="flex flex-col gap-2 mb-4">
        <label for="image" class="pl-2">Ảnh</label>
        <input
            type="file"
            id="image"
            class="border border-slate-300 rounded-md p-2"
            @change="onFileChange"
        >
      </div>
      <div class="flex justify-end gap-2">
        <button class="bg-red-500 text-white px-4 py-2 rounded-md" @click="closeEditModal">Hủy</button>
        <button class="bg-blue-500 text-white px-4 py-2 rounded-md" @click="submitEdit">Lưu</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, defineEmits, watch } from 'vue';

const props = defineProps({
  news: Object, // Tin tức được truyền từ cha
  editIndex: Number // Index được truyền từ cha
});

const emit = defineEmits(['close', 'editNews']); // Định nghĩa sự kiện gửi về cha

const newsData = ref({}); // Dữ liệu local cho modal

// Đồng bộ dữ liệu từ cha vào modal khi `props.news` thay đổi
watch(
    () => props.news,
    (newNews) => {
      newsData.value = { ...newNews }; // Sao chép dữ liệu để chỉnh sửa
    },
    { immediate: true } // Đồng bộ ngay khi modal được mở
);

// Đóng modal
const closeEditModal = () => {
  emit('close'); // Gửi sự kiện đóng modal về cha
};

// Gửi dữ liệu chỉnh sửa về cha
const submitEdit = () => {
  console.log('Submitting edit for index:', props.editIndex);
  console.log('Edited News Data:', newsData.value); // Log dữ liệu chỉnh sửa
  emit('editNews', { ...newsData.value, index: props.editIndex }); // Gửi dữ liệu chỉnh sửa
};
</script>

<style scoped>
</style>
