<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const route = useRoute();
const newsItem = ref(null);

const loadNewsItem = async () => {
  try {
    const response = await fetch(`http://localhost:8080/api/news/public/news/${route.params.title}`);
    if (!response.ok) {
      throw new Error(`Failed to fetch news item: ${response.statusText}`);
    }
    const data = await response.json();
    newsItem.value = data;
  } catch (error) {
    console.error('Error loading news item:', error);
  }
};

onMounted(() => {
  loadNewsItem();
});
</script>

<template>
  <div v-if="newsItem" class="news-item-container">
    <div class="news-item-image">
      <img :src="newsItem.image" alt="News Image" class="w-full h-full object-cover rounded-lg shadow-md">
    </div>
    <div class="news-item-content">
      <h1 class="text-4xl font-bold text-gray-900 mb-4">{{ newsItem.title }}</h1>
      <p class="text-gray-600 mb-4">{{ newsItem.content }}</p>
      <div class="text-gray-400 text-sm mb-2">{{ new Date(newsItem.posting_date).toLocaleDateString('vi-VN', { year: 'numeric', month: 'long', day: 'numeric' }) }}</div>
      <div class="text-gray-400 text-sm">Author: {{ newsItem.author }}</div>
    </div>
  </div>
</template>

<style scoped>
.news-item-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.news-item-image {
  width: 100%;
  height: 400px;
  margin-bottom: 20px;
}

.news-item-content {
  padding: 20px;
}

.news-item-content h1 {
  margin-bottom: 20px;
}

.news-item-content p {
  margin-bottom: 20px;
}
</style>