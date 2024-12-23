<script setup>
import { ref, computed, onMounted } from 'vue';

const newsList = ref([]);
const newsImg = [
  {
    image: require('@/assets/news/start-up.jpg')
  },
  {
    image: require('@/assets/news/winter_storm.jpg')
  },
  {
    image: require('@/assets/news/stonk.jpg')
  },
];

let announcements = ref([]);
//let hotnews = ref([]);
let vouchers = ref([]);


const isAscending = ref(true);

const toggleSortOrder = () => {
    if (isAscending.value) {
        newsList.value.sort((a, b) => new Date(a.posting_date) - new Date(b.posting_date));
    } else {
        newsList.value.sort((a, b) => new Date(b.posting_date) - new Date(a.posting_date));
    }
    isAscending.value = !isAscending.value;
};

const fetchNewsData = async () => {
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
    fetchNewsData();
    announcements = computed(() => newsList.value.filter(news => news.type === 'announcement'));
    //hotnews = computed(() => newsList.value.filter(news => news.type === 'hotnews'));
    vouchers = computed(() => newsList.value.filter(news => news.type === 'voucher'));
});
</script>

<template>
    <div class="w-full h-[700px] overflow-hidden relative">
        <img :src="require('@/assets/background/news_bg.jpg')"
            class="w-full h-full rounded-tl-lg rounded-tr-lg object-cover">
    </div>
    <section class="text-gray-600 body-font bg-gray-100">
        <div class="container px-5 py-24 mx-auto max-w-7x1">
            <div class="flex flex-wrap w-full mb-4 p-4">
                <div class="w-full mb-6 lg:mb-0">
                    <h1 class="sm:text-4xl text-5xl font-medium title-font mb-2 text-gray-900">Hot News</h1>
                    <div class="h-1 w-20 bg-gray-500 rounded"></div>
                </div>
            </div>
            <div class="flex justify-end mb-4">
                <button v-if="newsList.length" @click="toggleSortOrder" class="bg-gray-500 text-white px-4 py-2 rounded flex items-center">
                    Sort by Date
                    <svg v-if="isAscending" class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                    </svg>
                    <svg v-else class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
            </div>
            <div class="relative flex items-center">
                <button @click="prevSlide" class="absolute left-0 z-10 bg-black text-white p-2 rounded-full hover:bg-gray-700">‹</button>
                <div class="flex overflow-hidden w-full">
                    <div v-for="(item, index) in newsList" :key="index" class="w-1/3 p-2 box-border">
                        <router-link :to="'/news/' + item.title" class="block transform transition duration-300 hover:scale-105">
                            <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-lg">
                                <img :src="newsImg[index].image" alt="News Image"
                                    class="lg:h-60 xl:h-56 md:h-64 sm:h-72 xs:h-72 h-72 rounded w-full object-cover object-center mb-6">
                                <h3 class="tracking-widest text-gray-500 text-xs font-medium title-font">{{
                                    item.posting_date }}</h3>
                                <h2 class="text-lg text-gray-900 font-medium title-font mb-4">{{ item.title }}</h2>
                                <p class="leading-relaxed text-base">{{ item.content }}</p>
                                <p class="text-gray-400 text-sm">Author: {{ item.author }}</p>
                            </div>
                        </router-link>
                    </div>
                </div>
                <button v-if="newsList.length" @click="nextSlide"    class="absolute right-0 bg-black text-white p-2 rounded-full hover:bg-gray-700">›</button>
            </div>
        </div>
    </section>
    <section class="text-gray-600 body-font bg-gray-100">
        <div class="container px-5 py-24 mx-auto max-w-7x1">
            <div class="flex flex-wrap w-full mb-4 p-4">
                <div class="w-full mb-6 lg:mb-0">
                    <h1 class="sm:text-4xl text-5xl font-medium title-font mb-2 text-gray-900">Vouchers</h1>
                    <div class="h-1 w-20 bg-gray-500 rounded"></div>
                </div>
            </div>
            <div class="flex justify-end mb-4">
                <button @click="toggleSortOrder" class="bg-gray-500 text-white px-4 py-2 rounded flex items-center">
                    Sort by Date
                    <svg v-if="isAscending" class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                    </svg>
                    <svg v-else class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
            </div>
            <div class="flex flex-wrap -m-4">
                <button @click="prevSlide" class="absolute left-0 z-10 bg-black text-white p-2 rounded-full hover:bg-gray-700">‹</button>
                <div v-for="(item, index) in vouchers" :key="index" class="xl:w-1/3 md:w-1/2 p-4">
                    <router-link :to="'/news/' + item.title" class="block transform transition duration-300 hover:scale-105">
                        <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-lg">
                            <img :src="item.image" alt="News Image"
                                class="lg:h-60 xl:h-56 md:h-64 sm:h-72 xs:h-72 h-72 rounded w-full object-cover object-center mb-6">
                            <h3 class="tracking-widest text-gray-500 text-xs font-medium title-font">{{
                                item.posting_date }}</h3>
                            <h2 class="text-lg text-gray-900 font-medium title-font mb-4">{{ item.title }}</h2>
                            <p class="leading-relaxed text-base">{{ item.content }}</p>
                            <p class="text-gray-400 text-sm">Author: {{ item.author }}</p>
                        </div>
                    </router-link>
                </div>
                <button v-if="newsList.length" @click="nextSlide"    class="absolute right-0 bg-black text-white p-2 rounded-full hover:bg-gray-700">›</button>
            </div>
        </div>
    </section>
    <section class="text-gray-600 body-font bg-gray-100">
        <div class="container px-5 py-24 mx-auto max-w-7x1">
            <div class="flex flex-wrap w-full mb-4 p-4">
                <div class="w-full mb-6 lg:mb-0">
                    <h1 class="sm:text-4xl text-5xl font-medium title-font mb-2 text-gray-900">Announcements</h1>
                    <div class="h-1 w-20 bg-gray-500 rounded"></div>
                </div>
            </div>
            <div class="flex justify-end mb-4">
                <button @click="toggleSortOrder" class="bg-gray-500 text-white px-4 py-2 rounded flex items-center">
                    Sort by Date
                    <svg v-if="isAscending" class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 15l7-7 7 7"></path>
                    </svg>
                    <svg v-else class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
            </div>
            <div class="flex flex-wrap -m-4">
                <button @click="prevSlide" class="absolute left-0 z-10 bg-black text-white p-2 rounded-full hover:bg-gray-700">‹</button>
                <div v-for="(item, index) in announcements" :key="index" class="xl:w-1/3 md:w-1/2 p-4">
                    <router-link :to="'/news/' + item.title" class="block transform transition duration-300 hover:scale-105">
                        <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-lg">
                            <img :src="item.image" alt="News Image"
                                class="lg:h-60 xl:h-56 md:h-64 sm:h-72 xs:h-72 h-72 rounded w-full object-cover object-center mb-6">
                            <h3 class="tracking-widest text-gray-500 text-xs font-medium title-font">{{
                                item.posting_date }}</h3>
                            <h2 class="text-lg text-gray-900 font-medium title-font mb-4">{{ item.title }}</h2>
                            <p class="leading-relaxed text-base">{{ item.content }}</p>
                            <p class="text-gray-400 text-sm">Author: {{ item.author }}</p>
                        </div>
                    </router-link>
                </div>

                <button v-if="newsList.length" @click="nextSlide"    class="absolute right-0 bg-black text-white p-2 rounded-full hover:bg-gray-700">›</button>
            </div>
        </div>
    </section>
</template>

<script>
export default {
    data() {
        return {
            newsList: [], // Assuming this is populated with your news items
            currentIndex: 0
        };
    },
    computed: {
        visibleNews() {
            return this.newsList.slice(this.currentIndex, this.currentIndex + 3);
        }
    },
    methods: {
        prevSlide() {
            if (this.currentIndex > 0) {
                this.currentIndex -= 3;
            }
        },
        nextSlide() {
            if (this.currentIndex + 3 < this.newsList.length) {
                this.currentIndex += 3;
            }
        }
    }
};
</script>

<style scoped>

</style>