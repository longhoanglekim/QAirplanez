<template>
<header class="fixed w-full z-50 transition-all duration-300" :class="{ 'bg-black bg-opacity-80': isScrolled || mobileMenuOpen }">
    <div class="container mx-auto px-4 py-4 flex justify-between items-center">
        <!-- Logo -->
        <div class="logo">
            <a href="/" class="text-white text-2xl font-bold">
                <img src="/path-to-logo.png" alt="Aovis Logo" class="h-10">
            </a>
        </div>

        <!-- desktop Navigation chirnh ở script phía dưới-->
        <nav class="hidden lg:flex items-center space-x-8">
            <!-- các item to-->
            <div v-for="(item, index) in menuItems" :key="index" class="group relative cursor-pointer py-2 ">
                <div class="flex items-center justify-between space-x-5  px-4">
                    <a :href="item.link" class="text-white text-base font-medium uppercase tracking-wider hover:text-blue-900 transition-colors duration-300">
                        {{ item.label }}
                        <svg v-if="item.submenu" class="inline-block w-4 h-4 ml-1 text-white group-hover:text-blue-900 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                    </a>
                </div>

                <!-- các item nhỏ -->
                <div v-if="item.submenu" class="invisible absolute z-50 p-0.5 flex w-full flex-col bg-white rounded text-gray-800 shadow-xl group-hover:visible text-left">
                    <a v-for="(subitem, subindex) in item.submenu" :key="subindex" :href="subitem.link" class="rounded block px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-gray-100 transition-colors">
                        {{ subitem.label }}
                    </a>
                </div>
            </div>
        </nav>

        <!-- Phần còn lại của header -->
        <div class="flex items-center space-x-4">
            <!-- Search Button -->
            <button @click="toggleSearch" class="text-white hover:text-blue-900 transition-colors">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                </svg>
            </button>

            <!-- Các phần còn lại của header right actions -->
            <div class="hidden lg:flex items-center space-x-2">
                <svg class="w-6 h-6 text-blue-900" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 5.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                </svg>
                <span class="text-white text-base">+1 (234) 567-8910</span>
            </div>

            <!-- Mobile Menu Toggle -->
            <button @click="toggleMobileMenu" class="lg:hidden text-white hover:text-blue-900 transition-colors">
                <svg v-if="!mobileMenuOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                </svg>
                <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
    </div>
</header>
</template>

  
  
<script>
export default {
    data() {
        return {
            isScrolled: false,
            mobileMenuOpen: false,
            dropdownTimers: {}, // Lưu trữ các timer cho từng dropdown
            openMobileSubmenus: [],
            menuItems: [{
                    label: 'Trang chu',
                    link: '/home'
                },
                {
                    label: 'Pages',
                    link: '/pages',
                    submenu: [{
                            label: 'About',
                            link: '/about'
                        },
                        {
                            label: 'Team',
                            link: '/team'
                        },
                        {
                            label: 'Testimonials',
                            link: '/testimonials'
                        }
                    ]
                },
                {
                    label: 'Services',
                    link: '/services',
                    submenu: [{
                            label: 'Service Grid',
                            link: '/service-grid'
                        },
                        {
                            label: 'Service List',
                            link: '/service-list'
                        },
                        {
                            label: 'Service Details',
                            link: '/service-details'
                        }
                    ]
                },
                {
                    label: 'Projects',
                    link: '/projects',
                    submenu: [{
                            label: 'Project Grid',
                            link: '/project-grid'
                        },
                        {
                            label: 'Project Masonry',
                            link: '/project-masonry'
                        },
                        {
                            label: 'Project Details',
                            link: '/project-details'
                        }
                    ]
                },
                {
                    label: 'Blog',
                    link: '/blog',
                    submenu: [{
                            label: 'Blog Grid',
                            link: '/blog-grid'
                        },
                        {
                            label: 'Blog List',
                            link: '/blog-list'
                        },
                        {
                            label: 'Blog Details',
                            link: '/blog-details'
                        }
                    ]
                },
                {
                    label: 'Contact',
                    link: '/contact'
                }
            ]
        }
    },
    methods: {
        toggleSearch() {
            // Placeholder cho chức năng tìm kiếm
            alert('Chức năng tìm kiếm sẽ được thêm vào');
        },
        toggleMobileMenu() {
            this.mobileMenuOpen = !this.mobileMenuOpen;
            this.openMobileSubmenus = []; // Đặt lại submenu mobile
        }
    }
}
</script>
  
  
<style scoped>
 *{
    font-family: 'Poppins', 'Roboto', sans-serif;
 }
  </style>
