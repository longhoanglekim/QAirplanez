<template>
  <div>
    <div class="w-full h-[700px] overflow-hidden relative">
      <img :src="require('@/assets/background/home_bg.jpg')"
        class="w-full h-full rounded-tl-lg rounded-tr-lg object-cover ">
      <div class="h-full w-2/3 flex flex-col items-center text-center absolute -top-0 lg:-top-24 lg:-left-40 space-y-6 left-1/2 -translate-x-1/2 md:left-0 md:translate-x-0">
        <div ><img src="../../../../public/QAirline-12-21-2024.png" alt=""
          class=" animate-fade-right animate-once">
          </div>
        <div class="rounded-lg text-white absolute top-20 xl:top-80 xl:left-15 text-xl slogan text-center left-0 right-0 ">
          <p class="animate-fade-right animate-once p-3">Vui từng
          chuyến bay</p></div>
        </div>
        <div id="searchBox" class="absolute bottom-0 left-0 md:left-[24rem] lg:left-[40rem] xl:left-[60rem] 
                  md:top-0  right-0 flex items-center justify-center max-w-xl
                  animate-fade-left animate-once">
          <FlightSearch @search-flight="searchFlight" @search-ticket="searchTicket" />
        </div>
      </div>
      <div class="flex justify-center">
        <router-link to=""
          class="flex justify-center items-center h-48 w-64 border-2 border-orange-500 rounded-lg text-orange-500 p-3 m-4">
          <div class="">
            <Ticket class="w-24 h-24" />
            <span class="text-[1.5rem]">Đặt vé</span>
          </div>
        </router-link>
        <a href="/explore"
          class="flex justify-center items-center h-48 w-64 border-2 border-orange-500 rounded-lg text-orange-500 p-3 m-4">
          <div class="">
            <Earth class="w-24 h-24" />
            <span class="text-[1.5rem]">Địa điểm</span>
          </div>
        </a>
        <router-link to="#news"
          class="flex justify-center items-center h-48 w-64 border-2 border-orange-500 rounded-lg text-orange-500 p-3 m-4">
          <div class="">
            <Ticket class="w-24 h-24" />
            <span class="text-[1.5rem]">Tin tức</span>
          </div>
        </router-link>
      </div>
      <div class="custom-bg h-full p-8">
        <div id="news"
          class="space-x-0 md:space-x-6 mb-16 bg-white rounded-lg shadow-sm p-8 transition-all duration-300 ">
          <div class="w-full mb-4">
            <h2 class="text-2xl font-semibold mb-4 text-red-700">Tin mới nhất</h2>
          </div>
          <div class="flex flex-wrap md:flex-nowrap mb-16">
            <div v-if="sortedHotNews[0]" class="mb-4 lg:mb-0 p-4 lg:p-0 w-full md:w-1/2 relative block">
              <router-link :to="`/news/${sortedHotNews[0].title}`"
                class="group block transition-transform duration-300 hover:-translate-y-1">
                <div class="p-4 transition-all duration-300 group-hover:bg-orange-50">
                  <img :src="newsImg[0].image"
                    class="rounded-lg object-cover w-full h-64 shadow-sm transition-all duration-300 group-hover:shadow-md">
                  <h1 class="text-red-800 text-3xl font-semibold mt-4 mb-2 leading-tight 
                         transition-colors duration-300">
                    {{ sortedHotNews[0].title }}
                  </h1>
                  <p class="text-orange-900 mb-4 line-clamp-3 transition-colors duration-300 group-hover:text-red-700">
                    {{ sortedHotNews[0].content }}
                  </p>
                  <div class="text-orange-500 text-sm">
                    {{ formatDate(sortedHotNews[0].postingDate) }}
                  </div>
                </div>
              </router-link>
            </div>

            <div class="w-full md:w-1/2">
              <div v-for="(post, index) in otherHotNews" :key="post.title"
                class="rounded-lg w-full flex flex-col md:flex-row mb-6">
                <router-link :to="`/news/${post.title}`"
                  class="group flex flex-col md:flex-row w-full transition-transform duration-300 hover:-translate-y-1">
                  <div
                    class="flex flex-col md:flex-row w-full transition-all duration-300 group-hover:bg-orange-50 p-2">
                    <img :src="newsImg[index].image"
                      class="block rounded-lg w-full md:w-32 h-32 object-cover m-4 md:m-0 shadow-sm transition-all duration-300 group-hover:shadow-md" />
                    <div class="bg-transparent px-4 py-3 w-full md:w-3/4 ml-0 md:ml-4">
                      <div class="md:mt-0 text-red-800 font-medium text-lg mb-2 
                              transition-colors duration-300">
                        {{ post.title }}
                      </div>
                      <p
                        class="text-orange-900 text-sm line-clamp-2 transition-colors duration-300 group-hover:text-red-700">
                        {{ post.content }}
                      </p>
                      <div class="text-orange-500 text-sm mt-2">
                        {{ formatDate(post.postingDate) }}
                      </div>
                    </div>
                  </div>
                </router-link>
              </div>

              <div class="text-center mt-8">
                <router-link to="/news"
                  class="text-red-600 text-sm font-medium transition-colors duration-300 hover:text-red-700">
                  View all articles →
                </router-link>
              </div>
            </div>
          </div>
          <div class="flex flex-wrap mb-16">
            <div v-for="item in sortedVouchers" :key="item.title" class="w-full md:w-1/3 p-4">
              <router-link :to="`/news/${item.title}`"
                class="group block transition-transform duration-300 hover:-translate-y-1">
                <div class="p-4 transition-all duration-300 group-hover:bg-orange-50">
                  <img :src="item.image"
                    class="rounded-lg object-cover w-full h-32 shadow-sm transition-all duration-300 group-hover:shadow-md">
                  <h3 class="text-red-800 text-xl font-semibold mt-4 mb-2 leading-tight 
                           transition-colors duration-300">
                    {{ item.title }}
                  </h3>
                  <p class="text-orange-900 mb-4 line-clamp-2 transition-colors duration-300 group-hover:text-red-700">
                    {{ item.content }}
                  </p>
                  <div class="text-orange-500 text-sm">
                    {{ formatDate(item.postingDate) }}
                  </div>
                </div>
              </router-link>
            </div>
          </div>
          
          <div class="flex flex-wrap mb-16">
            <div v-for="item in sortedAnnouncements" :key="item.title" class="w-full md:w-1/3 p-4">
              <router-link :to="`/news/${item.title}`"
                class="group block transition-transform duration-300 hover:-translate-y-1">
                <div class="p-4 transition-all duration-300 group-hover:bg-orange-50">
                  <img :src="item.image"
                    class="rounded-lg object-cover w-full h-32 shadow-sm transition-all duration-300 group-hover:shadow-md">
                  <h3 class="text-red-800 text-xl font-semibold mt-4 mb-2 leading-tight 
                           transition-colors duration-300">
                    {{ item.title }}
                  </h3>
                  <p class="text-orange-900 mb-4 line-clamp-2 transition-colors duration-300 group-hover:text-red-700">
                    {{ item.content }}
                  </p>
                  <div class="text-orange-500 text-sm">
                    {{ formatDate(item.postingDate) }}
                  </div>
                </div>
              </router-link>
            </div>

          </div>
        </div>
      </div>
      <div id="explore" class="h-full p-8 mt-8 bg-orange-50">
        <ExploreUser />
      </div>
    </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import FlightSearch from '@/components/User/FlightSearch.vue';
import ExploreUser from '@/view/User/home/ExploreUser.vue';
import { Ticket, Earth } from 'lucide-vue-next';

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

const sortedHotNews = computed(() => {
  return [...newsList.value].sort((a, b) =>
    new Date(b.postingDate) - new Date(a.postingDate)
  );
});

const sortedAnnouncements = computed(() => {
  return [...announcements.value].sort((a, b) =>
    new Date(b.postingDate) - new Date(a.postingDate)
  ).slice(0, 4);
});

const sortedVouchers = computed(() => {
  return [...vouchers.value].sort((a, b) =>
    new Date(b.postingDate) - new Date(a.postingDate)
  ).slice(0, 4);
});

const otherHotNews = computed(() => {
  return sortedHotNews.value.slice(1, 4);
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
    console.log('Loaded news:', data);
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
      this.$router.push('/booking/done/0')
    }
  },
  name: 'HomeUser',
  mounted() {
    document.title = 'Trang chủ';
  }
}
</script>

<style scoped>
.qairline {
  background-image: url('../../../../public/QAirline-12-21-2024.png');
  z-index: 100000;
}

@font-face {
  font-family: 'Betterday Script';
  src: url("//src//frontend/public/Betterday\ Script\ [demo].ttf");
}

.slogan {
  font-family: 'Betterday Script', cursive;
  font-size: 1.8rem;
}
</style>