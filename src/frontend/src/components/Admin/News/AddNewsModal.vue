<template>
    <div class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center text-left">
        <div class="bg-white p-4 rounded-md w-1/2">
            <h1 class="text-2xl font-bold text-center">Thêm tin tức</h1>
            <form enctype="multipart/form-data" @submit.prevent="postNews">
                <div class="flex flex-col gap-2 mb-4">
                    <label for="title" class="pl-2">Tiêu đề</label>
                    <input type="text" id="title" class="border border-slate-300 rounded-md p-2" v-model="title">
                </div>
                <div class="flex flex-col gap-2 mb-4">
                    <label for="content" class="pl-2">Nội dung</label>
                    <input type="text" id="content" class="border border-slate-300 rounded-md p-2" v-model="content">
                </div>
                <div class="flex flex-col gap-2 mb-4">
                    <label for="image" class="pl-2">Ảnh</label>
                    <input 
                        type="file" 
                        id="image" 
                        class="border border-slate-300 rounded-md p-2" 
                        @change="handleFileChange"
                    >
                </div>
                <div class="flex justify-end gap-2">
                    <button type="button" class="bg-red-500 text-white px-4 py-2 rounded-md" @click="closeAddNewsModal">Hủy</button>
                    <button class="bg-blue-500 text-white px-4 py-2 rounded-md">Đăng</button>
                </div>
            </form>
            
        </div>
    </div>
</template>

<script setup>
import { ref ,defineEmits} from 'vue';
const emit = defineEmits(['close', 'postNews']);
const title = ref('');
const content = ref('');
const image = ref(null);
const closeAddNewsModal = () => {
    emit('close');
}

const formData = new FormData();

const handleFileChange = (event) => {
    image.value = event.target.files[0];
    if (image.value) {
      console.log("chua truyen anh");
    }
}
const postNews = async () => {
    formData.append('title', title.value);
    formData.append('content', content.value);
    if(image.value) {
        formData.append('image', image.value);
        console.log("yes")
    } else {
        console.error('No image selected');
    }
    
    try {
        const response = await fetch('http://localhost:8080/api/news/admin_news/create', {
        method: 'POST',
        headers: {
            Authorization: `Bearer ${localStorage.getItem('adminToken')}`
        },
        body: formData
    });

        if (!response.ok) {
        throw new Error(`Failed to post news: ${response.statusText}`);
        }

        const result = await response.json();
        console.log('Post news result:', result);
        emit('postNews')
        
    } catch (error) {
    console.error('Error posting news:', error);
    alert('Có lỗi xảy ra khi thêm tin tức. Vui lòng thử lại.');
  }
}
</script>

<style  scoped>

</style>