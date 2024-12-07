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
            <td>{{ item.id }}</td>
            <td>{{ item.title }}</td>
            <td>{{ item.date }}</td>
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
const newsList = ref([]);
const isAddNewsModalOpen = ref(false);
// Sample news data
newsList.value = [
  {
    id: 1,
    title: 'QAirline mở đường bay mới đến Phú Quốc',
    date: '2024-01-15',
    image: 'phu-quoc-route.jpg',
    content: 'QAirline vui mừng thông báo mở đường bay mới kết nối TP.HCM với Phú Quốc, bắt đầu từ tháng 2/2024...'
  },
  {
    id: 2, 
    title: 'Chương trình khuyến mãi mùa xuân 2024',
    date: '2024-01-10',
    image: 'spring-promo.jpg',
    content: 'Chào đón mùa xuân 2024, QAirline triển khai chương trình khuyến mãi đặc biệt với nhiều ưu đãi hấp dẫn...'
  },
  {
    id: 3,
    title: 'QAirline đạt chứng nhận an toàn 5 sao',
    date: '2024-01-05', 
    image: 'safety-cert.jpg',
    content: 'QAirline tự hào thông báo đã đạt chứng nhận an toàn 5 sao từ tổ chức đánh giá hàng không quốc tế...'
  },
  {
    id: 4,
    title: 'Nâng cấp đội bay với máy bay thế hệ mới',
    date: '2024-01-01',
    image: 'new-aircraft.jpg', 
    content: 'QAirline vừa ký kết hợp đồng mua thêm 5 máy bay thế hệ mới, dự kiến đưa vào khai thác từ quý 3/2024...'
  }
]


const addNews = () => {
  isAddNewsModalOpen.value = true;
}
const closeAddNewsModal = () => {
  isAddNewsModalOpen.value = false;
}
const postNews = (news) => {
  newsList.value.push({
    ...news,
    id: newsList.value.length + 1,
    date: new Date().toISOString().split('T')[0],
    image: news.image ? news.image : '@/assets/logo.png'
  });
  isAddNewsModalOpen.value = false;
}
const deleteNews = (id) => {
  newsList.value = newsList.value.filter(item => item.id !== id);
}
</script>

<style scoped>

</style>