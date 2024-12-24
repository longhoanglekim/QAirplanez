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
        <tr v-for="item in newsList" :key="item.title">
          <td>{{ item.index }}</td>
          <td>{{ item.title }}</td>
          <td>{{ item.formattedPostingDate }}</td>
          <td><img :src="item.urlImage" alt="Ảnh" class="w-20 h-20 object-cover"></td>
          <td>{{ item.content }}</td>
          <td>
            <div class="relative">
              <button @click="toggleDropdown(item.index)" class="bg-gray-300 text-black px-3 py-1 rounded-md hover:bg-gray-400">
                Hành động
              </button>
              <div
                  v-show="dropdownIndex === item.index"
                  class="absolute bg-white border border-gray-300 rounded-md shadow-md mt-1 right-0 w-32 z-10">
                <button
                    @click="deleteNews(item.index)"
                    class="block w-full text-left px-4 py-2 hover:bg-red-100 hover:text-red-600">
                  Xóa
                </button>
                <button
                    @click="openEditNews(item.index)"
                    class="block w-full text-left px-4 py-2 hover:bg-blue-100 hover:text-blue-600">
                  Sửa
                </button>
              </div>
            </div>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <AddNewsModal v-if="isAddNewsModalOpen" @close="closeAddNewsModal" @postNews="postNews"/>
    <EditNewsModal v-if="isEditNewsModalOpen" :editIndex="editNewsIndex"
                   :news="newsList.find(item => item.index === editNewsIndex)"
                   @close="closeEditNewsModal" @editNews="editNews"/>
  </div>
</template>

<script setup>
import { PlusIcon } from 'lucide-vue-next';
import { onMounted, ref } from 'vue';
import AddNewsModal from './AddNewsModal.vue';
import { newsStore } from "@/store/newsStore";

import EditNewsModal from "@/components/Admin/News/EditNewsModal.vue";

const newsList = ref([]); // Danh sách tin tức
const isAddNewsModalOpen = ref(false); // Trạng thái mở modal thêm tin tức
const isEditNewsModalOpen = ref(false); // Trạng thái mở modal thêm tin tức
const dropdownIndex = ref(null); // Trạng thái dropdown
const editNewsIndex = ref(null);
// Thêm tin tức
const addNews = () => {
  isAddNewsModalOpen.value = true;
};
const openEditNews = (index) => {
  isEditNewsModalOpen.value = true;
  editNewsIndex.value = index;
  dropdownIndex.value = null;
}

const closeAddNewsModal = () => {
  isAddNewsModalOpen.value = false;
};
const closeEditNewsModal = () => {
  isEditNewsModalOpen.value = false;
};

// Post tin tức mới
const postNews = async () => {
  isAddNewsModalOpen.value = false;
  try {
        const  response = await fetch('http://localhost:8080/api/news/public/newsList', {
            method : 'Get',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
            }
        });
        if (response.ok) {
            newsList.value = await response.json();
        }
    } catch(error) {
        console.log(error);
    }
};

// Xóa tin tức
const deleteNews = (id) => {
  const isConfirmed = confirm('Bạn có chắc chắn muốn xóa tin này không?');
  if (isConfirmed) {
    newsList.value = newsList.value.filter(item => item.index !== id);
    newsList.value.forEach(item => {
      if (item.index > id) {
        item.index -= 1;
      }
    });
    newsStore().deleteNews(id);
    alert('Tin tức đã được xóa thành công!');
  } else {
    alert('Hủy xóa!');
  }
};

// Sửa tin tức
const editNews = (editedNews) => {
  // Tạo body JSON cho yêu cầu
  const body = {
    title: editedNews.title,
    postingDate: editedNews.postingDate,
    editDate: new Date().toISOString(),
    content: editedNews.content,
    imageList: editedNews.imageList, // Đảm bảo `imageList` là mảng chuỗi base64
  };

  console.log("Body JSON gửi đi:", body);

  // Tìm index của tin tức cần chỉnh sửa
  if (editNewsIndex.value !== -1) {
    // Cập nhật dữ liệu trong `newsList`
    newsList.value[editNewsIndex.value] = {
      ...newsList.value[editNewsIndex.value],
      ...body, // Cập nhật dữ liệu mới
    };

    // Gửi dữ liệu đến backend
    newsStore()
        .editNews(editNewsIndex.value, body)
        .then(() => {
          alert("Cập nhật tin tức thành công!");
          closeEditNewsModal();
        })
        .catch((error) => {
          console.error("Lỗi khi cập nhật tin tức:", error);
          alert("Cập nhật tin tức thất bại.");
        });
  }
};


// Bật/Tắt dropdown
const toggleDropdown = (index) => {
  if (dropdownIndex.value === index) {
    dropdownIndex.value = null; // Đóng dropdown nếu đang mở
  } else {
    dropdownIndex.value = index; // Mở dropdown
  }
};


onMounted(async () => {
  newsList.value = await newsStore().getNews();
  console.log('newsList:', newsList.value);
});
</script>

<style scoped>
.relative {
  position: relative;
}
.absolute {
  position: absolute;
}
</style>
