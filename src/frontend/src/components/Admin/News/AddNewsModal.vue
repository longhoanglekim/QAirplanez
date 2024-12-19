<template>
    <div class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center text-left">
        <div class="bg-white p-4 rounded-md w-1/2">
            <h1 class="text-2xl font-bold text-center">Thêm tin tức</h1>
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
                    @change="(e) => image = e.target.files[0]"
                >
            </div>
            <div class="flex justify-end gap-2">
                <button class="bg-red-500 text-white px-4 py-2 rounded-md" @click="closeAddNewsModal">Hủy</button>
                <button class="bg-blue-500 text-white px-4 py-2 rounded-md" @click="postNews">Đăng</button>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref ,defineEmits} from 'vue';
const emit = defineEmits(['close', 'postNews']);
const title = ref('');
const content = ref('');
const image = ref('');
const closeAddNewsModal = () => {
    emit('close');
}
const postNews = () => {
    emit('postNews', {
        title: title.value,
        content: content.value,
        image: image.value
    });
}
</script>

<style  scoped>

</style>