<template>
  <header class="bg-white/50 fixed w-full z-50 top-0 transition-all duration-300">
    <div class="container mx-auto pt-1 flex justify-between items-center">
      <!-- Logo -->
      <div class="logo">
        <a href="/home" class="text-slate-500 text-2xl font-bold">
          <img src="@/assets/home/logo5122.png" alt="logo" class="h-10">
        </a>
      </div>

      <!-- desktop Navigation -->
      <nav class="hidden lg:flex items-center space-x-8">
        <div v-for="(item, index) in menuItems" :key="index" class="group relative cursor-pointer">
          <div
            class="flex items-center justify-between rounded-full hover:text-orange-600 m-1 py-2 px-4 hover:bg-white text-slate-800">
            <a :href="item.link" class="text-md tracking-wider font-bold">
              {{ item.label }}
              <svg v-if="item.submenu" class="inline-block w-4 h-4 ml-1 transition-colors" fill="none"
                stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
              </svg>
            </a>
          </div>

          <div v-if="item.submenu"
            class="group-hover:visible invisible absolute z-50 p-0.5 flex flex-col bg-white rounded text-gray-800 shadow-xl text-left w-52">
            <a v-for="(subitem, subindex) in item.submenu" :key="subindex" :href="subitem.link"
              class="rounded block px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-slate-100 transition-colors">
              {{ subitem.label }}
            </a>
          </div>
        </div>
      </nav>

      <!-- Header Actions -->
      <div class="flex items-center space-x-4">
        <!-- Search Button -->
        <button @click="toggleSearch" class="text-white hover:text-blue-900 transition-colors">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </button>

        <div v-if='!isLoggedIn()' class="hidden lg:flex items-center space-x-2">
          <a href="/login"
            class="block text-sm px-4 py-2 rounded-full w-32 ml-2 font-bold text-center text-slate-800x border-slate-800 border-2">
            <span class="w-fit mx-auto">Đăng nhập</span>
          </a>
          <a href="/signup"
            class="block text-sm px-4 py-2 rounded-full w-32 ml-2 font-bold text-center text-white signup">
            <span class="w-fit mx-auto">Đăng ký</span>
          </a>
        </div>

        <div v-if="isLoggedIn()" class="group relative cursor-pointer p-2">
          <img :src="imageData" class="w-8 h-8 rounded-full" alt="avt" />
          <div
            class="group-hover:visible invisible absolute right-0 z-50 p-0.5 bg-white rounded text-gray-800 shadow-xl text-left w-48">
            <button @click="handleProfileItemClick(profileItems[0])"
              class="block rounded px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-gray-100 transition-colors w-48">
              {{ profileItems[0].label }}
            </button>
            <button @click="handleProfileItemClick(profileItems[1])"
              class="block rounded px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-gray-100 transition-colors w-48">
              {{ profileItems[1].label }}
            </button>
            <button @click="handleProfileItemClick(profileItems[2])"
              class="block rounded px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-gray-100 transition-colors w-48">
              {{ profileItems[2].label }}
            </button>
          </div>
        </div>

        <button @click="toggleMobileMenu"
          class="lg:hidden text-white hover:text-blue-900 transition-colors bg-black rounded">
          <svg v-if="!mobileMenuOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
          </svg>
          <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>
    </div>

    <div v-if="mobileMenuOpen" class="fixed inset-0 bg-black/50 lg:hidden z-40 w-1/2">
      <div class="container mx-auto px-4 py-8">
        <div v-for="(item, index) in menuItems" :key="index" class="mb-6">
          <div @click="toggleMobileSubmenu(index)"
            class="text-white text-2xl font-bold uppercase flex justify-between items-center">
            <a :href="item.link" class=" text-md tracking-wider transition-colors duration-300">
              {{ item.label }}
            </a>
            <svg v-if="item.submenu" class="w-6 h-6 transform"
              :class="{ 'rotate-180': openMobileSubmenus.includes(index) }" fill="none" stroke="currentColor"
              viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
            </svg>
          </div>

          <div v-if="item.submenu && openMobileSubmenus.includes(index)" class="mt-4 space-y-3">
            <a v-for="(subitem, subindex) in item.submenu" :key="subindex" :href="subitem.link"
              class="block text-white text-xl hover:text-yellow-500 transition-colors">
              {{ subitem.label }}
            </a>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  data() {
    return {
      imageData: null,
      isScrolled: false,
      mobileMenuOpen: false,
      dropdownTimers: {},
      openMobileSubmenus: [],
      profileItems: [
        {
          label: 'Thông tin cá nhân',
          link: '/user',
          action: this.navigateToProfile,
        },
        {
          label: 'Cài đặt',
          link: '/setting',
          action: this.navigateToSettings,
        },
        {
          label: 'Đăng xuất',
          link: '/logout',
          action: this.handleLogout,
        },
      ],
      menuItems: [
        { label: 'Trang chủ', link: '/home' },
        {
          label: 'Khám phá',
          link: '/explore',
        },
        { label: 'Tin tức', link: '/news' },
        {
          label: 'Services',
          link: '/services',
          submenu: [
            { label: 'Service Grid', link: '/service-grid' },
            { label: 'Service List', link: '/service-list' },
            { label: 'Service Details', link: '/service-details' },
          ],
        }
      ],
    };
  },
  mounted() {
    window.addEventListener('scroll', this.handleScroll);
    this.fetchImage();
    this.isLoggedIn();
  },
  beforeUnmount() {
    window.removeEventListener('scroll', this.handleScroll);
    this.isLoggedIn();
  },

  methods: {
    isLoggedIn() {
      return localStorage.getItem('token') != null;
    },
    handleScroll() {
      this.isScrolled = window.scrollY > 30;
    },
    toggleSearch() {
      alert('chua co tinh nang nay');
    },
    toggleMobileMenu() {
      this.mobileMenuOpen = !this.mobileMenuOpen;
      this.openMobileSubmenus = []; // Reset open submenus
    },
    toggleMobileSubmenu(index) {
      if (this.openMobileSubmenus.includes(index)) {
        this.openMobileSubmenus = this.openMobileSubmenus.filter((i) => i !== index);
      } else {
        this.openMobileSubmenus.push(index);
      }
    },
    async fetchImage() {
      try {
        const response = await fetch('http://localhost:8080/api/user/getAvatar', {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`, // Thêm token nếu cần
          },
        });

        if (!response.ok) {
          throw new Error('Unable to fetch image');
        }

        const data = await response.json();
        this.imageData = data.imageUrl ? `${data.imageUrl}` : '';
      } catch (error) {
        console.error(error);
      }
    },
    async navigateToProfile() {
      try {
        // Get token from localStorage or your authentication store
        const token = localStorage.getItem('token');
        console.log(token);
        if (!token) {
          // Redirect to login if no token
          this.$router.push('/login');
          return;
        }

        // Verify token before navigation
        // const response = await fetch('http://localhost:8080/api/user/currentUser', {
        //   method: 'GET',
        //   headers: {
        //     Authorization: `Bearer ${localStorage.getItem('token')}`, // Thêm token nếu cần
        //   }
        // });
        //
        // if (!response.ok) {
        //   // Token is invalid or expired
        //   throw new Error('Unauthorized');
        // }

        // If verification is successful, navigate to profile
        this.$router.push('/user');
      } catch (error) {
        // Handle token verification failure
        console.error('Profile access error:', error);

        // Clear invalid token
        localStorage.removeItem('authToken');

        // Redirect to login
        this.$router.push('/login');
      }
    },
    async navigateToSettings() {
      console.log('Navigating to settings...');
    },
    handleLogout() {
      localStorage.removeItem('token');
      this.isLoggedIn();
      this.$router.push('/login');
    },
    handleProfileItemClick(item) {
      // Execute the respective action when a profile item is clicked
      item.action();
    },
  },
};
</script>


<style scoped>
.signup {
  background: linear-gradient(90deg, rgba(131,58,180,1) 0%, rgba(245,97,43,1) 0%, rgba(252,210,69,1) 100%);
}
</style>