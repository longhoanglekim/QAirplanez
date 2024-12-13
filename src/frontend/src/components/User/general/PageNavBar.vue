<template>
<header  class="bg-white/50 fixed w-full z-50 top-0 transition-all duration-300" >
    <div class="container mx-auto pt-1 flex justify-between items-center">
        <!-- Logo -->
        <div class="logo">
            <a href="/home" class="text-slate-500 text-2xl font-bold">
                <img src="@/assets/home/logo5122.png" alt="logo" class="h-10">
            </a>
        </div>

        <!-- desktop Navigation chirnh ở script phía dưới-->
        <nav class="hidden lg:flex items-center space-x-8">
            <!-- các item to-->
            <div v-for="(item, index) in menuItems" :key="index" class="group relative cursor-pointer">
                <div class="flex items-center justify-between rounded-full hover:text-orange-600 m-1 py-2 px-4 hover:bg-white text-slate-800">
                    <a :href="item.link" class=" text-md tracking-wider font-bold   ">
                        {{ item.label }}
                        <svg v-if="item.submenu" class="inline-block w-4 h-4 ml-1 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                    </a>
                </div>

                <!-- các item nhỏ -->
                <div v-if="item.submenu" class="group-hover:visible invisible absolute z-50 p-0.5 flex flex-col bg-white rounded text-gray-800 shadow-xl text-left w-52">
                    <a v-for="(subitem, subindex) in item.submenu" :key="subindex" :href="subitem.link" class="rounded block px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-slate-100 transition-colors">
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
            <div v-if='!isLoggedIn()' class="hidden lg:flex items-center space-x-2">
                <a href="/signup" class="block text-md px-4 py-2 rounded-full w-32 ml-2 font-bold text-slate-800 mt-4 hover:bg-blue-700 lg:mt-0">
                    Đăng ký
                </a>
                <a href="/login" class="block text-md px-4 ml-2 py-2 rounded-full w-32 font-bold text-slate-800 mt-4 hover:bg-blue-700 lg:mt-0">
                    Đăng nhập
                </a>
            </div>

            <div v-if="isLoggedIn()" class="group relative cursor-pointer p-2">
                <img :src="imageData" class="w-8 h-8 rounded-full" alt="avt"/>
                <div class="group-hover:visible invisible absolute right-0 z-50 p-0.5 bg-white rounded text-gray-800 shadow-xl text-left w-48">
                    <a v-for="(item, index) in profileItems" :key="index" :href="item.link" class="rounded block px-6 py-3 text-gray-800 hover:text-blue-900 hover:bg-gray-100 transition-colors w-48">
                        {{ item.label }}
                    </a>
                </div>
            </div>

            <!-- Mobile Menu Toggle -->
            <button @click="toggleMobileMenu" class="lg:hidden text-white hover:text-blue-900 transition-colors bg-black rounded">
                <svg v-if="!mobileMenuOpen" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                </svg>
                <svg v-else class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
            </button>
        </div>
    </div>
    <!-- Mobile Menu Overlay -->
    <div v-if="mobileMenuOpen" class="fixed inset-0 bg-black/50 lg:hidden z-40 w-1/2">
        <div class="container mx-auto px-4 py-8">
            <div v-for="(item, index) in menuItems" :key="index" class="mb-6">
                <div @click="toggleMobileSubmenu(index)" class="text-white text-2xl font-bold uppercase flex justify-between items-center">
                    <a :href="item.link" class=" text-md tracking-wider transition-colors duration-300">
                        {{ item.label }}
                    </a>
                    <svg v-if="item.submenu" class="w-6 h-6 transform" :class="{'rotate-180': openMobileSubmenus.includes(index)}" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                    </svg>
                </div>

                <div v-if="item.submenu && openMobileSubmenus.includes(index)" class="mt-4 space-y-3">
                    <a v-for="(subitem, subindex) in item.submenu" :key="subindex" :href="subitem.link" class="block text-white text-xl hover:text-yellow-500 transition-colors">
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
            imageData : null,
            isScrolled: false,
            mobileMenuOpen: false,
            dropdownTimers: {}, // Lưu trữ các timer cho từng dropdown
            openMobileSubmenus: [],
            profileItems: [{
                label: 'Thong tin ca nhan',
                link: '/profile'
            }, {
                label: 'Cai dat',
                link: '/setting'
            }, {
                label: 'Dang xuat',
                link: '/logout'
            }

            ],
            menuItems: [{
                    label: 'Trang chủ',
                    link: '/home'
                },
                {
                    label: 'Kham pha',
                    link: '/explore',
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
    mounted() {
        window.addEventListener('scroll', this.handleScroll)
        this.fetchImage();
    },
    beforeUnmount() {
        window.removeEventListener('scroll', this.handleScroll)
    },

    methods: {
        isLoggedIn() {
          return (localStorage.getItem('token') != null);
        },
        handleScroll() {
            this.isScrolled = window.scrollY > 30
        },
        toggleSearch() {
            // Implement search functionality
            alert('chua co tinh nang nay')
        },
        toggleMobileMenu() {
            this.mobileMenuOpen = !this.mobileMenuOpen
            this.openMobileSubmenus = [] // Reset open submenus
        },
        toggleMobileSubmenu(index) {
            if (this.openMobileSubmenus.includes(index)) {
                this.openMobileSubmenus = this.openMobileSubmenus.filter(i => i !== index)
            } else {
                this.openMobileSubmenus.push(index)
            }
        },
        async fetchImage() {
          try {
            // Gửi request để lấy ảnh từ server (API trả về base64)
            const response = await fetch('http://localhost:8080/api/user/getAvatar', {
              method: 'POST',
              headers: {
                Authorization : `Bearer ${localStorage.getItem('token')}` // Thêm token nếu cần
              }
            });

            // Nếu request thất bại
            if (!response.ok) {
              throw new Error('Unable to fetch image');
            }

            const data = await response.json(); // Giả sử API trả về dữ liệu có trường 'image' chứa base64
            this.imageData = data.imageUrl ? `${data.imageUrl}` : ''; // Nếu có dữ liệu, gán vào imageData
            this.uploadStatus = 'Image loaded successfully!';
            this.statusClass = 'text-green-500';
          } catch (error) {
            this.uploadStatus = error.message || 'Failed to load image';
            this.statusClass = 'text-red-500';
          }
        }
    }
}
</script>

<style scoped>


</style>
