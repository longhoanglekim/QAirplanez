<template>
<header  class="fixed w-full z-50 transition-all duration-300 bg-black/40 md:bg-black/10" :class="{'md:bg-black/40 top-0': isScrolled}">
    <div class="container mx-auto pt-1 flex justify-between items-center">
        <!-- Logo -->
        <div class="logo">
            <a href="/home" class="text-white text-2xl font-bold">
                <img src="@/assets/home/logo5122.png" alt="logo" class="h-10">
            </a>
        </div>

        <!-- desktop Navigation chirnh ở script phía dưới-->
        <nav class="hidden lg:flex items-center space-x-8">
            <!-- các item to-->
            <div v-for="(item, index) in menuItems" :key="index" class="group relative cursor-pointer py-2 ">
                <div class="flex items-center justify-between rounded-full m-1 py-1 px-4 hover:bg-blue-700 text-white">
                    <a :href="item.link" class=" text-md tracking-wider transition-colors duration-300">
                        {{ item.label }}
                        <svg v-if="item.submenu" class="inline-block w-4 h-4 ml-1 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                        </svg>
                    </a>
                </div>

                <!-- các item nhỏ -->
                <div v-if="item.submenu" class="group-hover:visible invisible absolute z-50 p-0.5 flex w-full flex-col bg-white rounded text-gray-800 shadow-xl text-left w-52">
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
            <div v-if='!isLoggedIn()' class="hidden lg:flex items-center space-x-2">
                <a href="/signup" class="block text-md px-4 py-2 rounded-full w-32 ml-2 font-bold text-white mt-4 hover:bg-blue-700 lg:mt-0">
                    Đăng ký
                </a>
                <a href="/login" class="block text-md px-4 ml-2 py-2 rounded-full w-32 font-bold text-white mt-4 hover:bg-blue-700 lg:mt-0">
                    Đăng nhập
                </a>
            </div>

            <div v-if="isLoggedIn()" class="group relative cursor-pointer p-2">
                <img class="w-8 h-8 rounded-full" src="@/assets/login/avt.jpeg" alt="Rounded avatar">
    
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
    mounted() {
        window.addEventListener('scroll', this.handleScroll)
    },
    beforeUnmount() {
        window.removeEventListener('scroll', this.handleScroll)
    },

    methods: {
        isLoggedIn() {
            return false;
        },
        handleScroll() {
            this.isScrolled = window.scrollY > 50
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
        }
    }
}
</script>

<style scoped>
* {
    font-family: 'Poppins', 'Roboto', sans-serif;
}
</style>
