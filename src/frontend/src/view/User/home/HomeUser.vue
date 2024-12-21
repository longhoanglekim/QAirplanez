<template>
  <div class="w-full h-[700px] overflow-hidden relative">
    <img :src="require('@/assets/background/home_bg.jpg')"
      class="w-full h-full rounded-tl-lg rounded-tr-lg object-cover">
    <div class="absolute inset-0 flex items-center justify-center">
      <FlightSearch @search-flight="searchFlight" @search-ticket="searchTicket" />
    </div>
  </div>
  <div class="h-full bg-gray-200 p-8">
    <div class="flex flex-wrap md:flex-nowrap space-x-0 md:space-x-6 mb-16 bg-white rounded-lg shadow-sm p-8 transition-all duration-300">
      <div v-if="sortedNews[0]" class="mb-4 lg:mb-0 p-4 lg:p-0 w-full md:w-1/2 relative block">
        <router-link :to="`/news/${sortedNews[0].title}`" 
                    class="group block transition-transform duration-300 hover:-translate-y-1">
          <div class="p-4 transition-all duration-300 group-hover:bg-gray-100">
            <img :src="sortedNews[0].image" 
                 class="rounded-lg object-cover w-full h-64 shadow-sm transition-all duration-300 group-hover:shadow-md">
            <h1 class="text-gray-800 text-3xl font-semibold mt-4 mb-2 leading-tight 
                       transition-colors duration-300">
              {{ sortedNews[0].title }}
            </h1>
            <p class="text-gray-600 mb-4 line-clamp-3 transition-colors duration-300 group-hover:text-gray-700">
              {{ sortedNews[0].content }}
            </p>
            <div class="text-gray-400 text-sm">
              {{ formatDate(sortedNews[0].postingDate) }}
            </div>
          </div>
        </router-link>
      </div>

      <div class="w-full md:w-1/2">
        <div v-for="post in limitedOtherNews" 
             :key="post.title" 
             class="rounded-lg w-full flex flex-col md:flex-row mb-6">
          <router-link :to="`/news/${post.title}`" 
                      class="group flex flex-col md:flex-row w-full transition-transform duration-300 hover:-translate-y-1">
            <div class="flex flex-col md:flex-row w-full transition-all duration-300 group-hover:bg-gray-100 p-2">
              <img :src="post.image" 
                   class="block rounded-lg w-full md:w-32 h-32 object-cover m-4 md:m-0 shadow-sm transition-all duration-300 group-hover:shadow-md" />
              <div class="bg-transparent px-4 py-3 w-full md:w-3/4 ml-0 md:ml-4">
                <div class="md:mt-0 text-gray-800 font-medium text-lg mb-2 
                            transition-colors duration-300">
                  {{ post.title }}
                </div>
                <p class="text-gray-600 text-sm line-clamp-2 transition-colors duration-300 group-hover:text-gray-700">
                  {{ post.content }}
                </p>
                <div class="text-gray-400 text-sm mt-2">
                  {{ formatDate(post.postingDate) }}
                </div>
              </div>
            </div>
          </router-link>
        </div>

        <div class="text-center mt-8">
          <router-link to="/news" 
                       class="text-gray-600 text-sm font-medium transition-colors duration-300">
            View all articles →
          </router-link>
        </div>
      </div>
    </div>
  </div>
  <div class="h-full p-8 mt-8 bg-gray-200">
    <ExploreUser />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import FlightSearch from '@/components/User/FlightSearch.vue';
import ExploreUser from '@/view/User/home/ExploreUser.vue';

const newsList = ref([]);

const sortedNews = computed(() => {
  return [...newsList.value].sort((a, b) =>
    new Date(b.postingDate) - new Date(a.postingDate)
  );
});

const limitedOtherNews = computed(() => {
  return sortedNews.value.slice(1, 4);
});

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString('vi-VN', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};

const loadNews = async () => {
  try {
    const response = await fetch('http://localhost:8080/api/news/public/newsList');
    if (!response.ok) {
      throw new Error(`Failed to fetch news: ${response.statusText}`);
    }
    const data = await response.json();
    newsList.value = data;
  } catch (error) {
    console.error('Error loading news:', error);
  }
};

onMounted(() => {
  loadNews();
});
</script>

<script>
export default {
  methods: {
    searchFlight() {
      this.$router.push('/booking/availability/0')
    },
    searchTicket() {
      console.log('searchTicket')
      this.$router.push('/booking/done/0')
    }
  },
  name: 'HomeUser',
  mounted() {
    document.title = 'Trang chủ';
  }
}
</script>

<style scoped></style>