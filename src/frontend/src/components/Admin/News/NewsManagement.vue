<template>
  <div>
    <div class="flex justify-between">
      <h1>Quản lý tin tức</h1>
      <button @click="addNews" class="bg-blue-500 text-white px-4 py-2 rounded-md flex items-center gap-2 hover:bg-blue-600">
        <PlusIcon class="w-4 h-4" /> 
        Thêm tin tức
      </button>
    </div>
    <div class="mt-4">
      <table class="w-full border-collapse border border-slate-400 rounded-md text-sm">
        <thead class="bg-slate-200 text-slate-600 font-bold text-sm uppercase tracking-wider">
          <tr class="rounded-md">
            <th>STT</th>
            <th>Tiêu đề</th>
            <th>Ngày đăng</th>
            <th>Ảnh</th>
            <th>Nội dung</th>
            <th>Thao tác</th>
          </tr> 
        </thead>
        <tbody class="text-left">
          <tr v-for="item in newsList" :key="item.id">
            <td>{{ item.index }}</td>
            <td>{{ item.title }}</td>
            <td>{{ item.postingDate }}</td>
            <td><img :src="item.image" alt="Ảnh" class="w-20 h-20 object-cover"></td>
            <td>{{ item.content }}</td>
            <td>
              <button @click="deleteNews(item.id)" class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600">
                Xóa
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <AddNewsModal v-if="isAddNewsModalOpen" @close="closeAddNewsModal" @postNews="postNews"/>
  </div>
</template>

<script setup>
import { PlusIcon } from 'lucide-vue-next';
import { ref } from 'vue';
import AddNewsModal from './AddNewsModal.vue';

import {news} from '@/assets/data';
const newsList = ref(news);
const isAddNewsModalOpen = ref(false);
// Sample news data



const addNews = () => {
  isAddNewsModalOpen.value = true;
}
const closeAddNewsModal = () => {
  isAddNewsModalOpen.value = false;
}
const postNews = async (news) => {
  try {
    // Tạo dữ liệu tin tức mới
    const newNews = {
      ...news,
      date: new Date().toISOString().split('T')[0],
      image: news.image ? news.image : '@/assets/logo.png'
    };
    console.log(JSON.stringify(newNews))
    // Gọi API để thêm tin tức
    const response = await fetch( 'http://localhost:8080/api/news/admin_news/create', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${localStorage.getItem('adminToken')}`
      },
      body: JSON.stringify(newNews)
    });

    if (!response.ok) {
      throw new Error(`Failed to post news: ${response.statusText}`);
    }

    // Lấy dữ liệu trả về từ API
    const result = await response.json();

    // Cập nhật newsList với dữ liệu trả về
    newsList.value.push({
      ...result, // Sử dụng dữ liệu từ API trả về (vd: ID tự sinh từ server)
      index: newsList.value.length + 1 // Cập nhật chỉ số
    });

    // Đóng modal
    isAddNewsModalOpen.value = false;
  } catch (error) {
    console.error('Error posting news:', error);
    alert('Có lỗi xảy ra khi thêm tin tức. Vui lòng thử lại.');
  }
};
const deleteNews = (id) => {
  newsList.value = newsList.value.filter(item => item.id !== id);
}
</script>

<style scoped>

</style>