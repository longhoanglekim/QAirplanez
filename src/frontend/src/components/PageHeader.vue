<template>
<div class="flex justify-between items-center">
    <a class="block text-md px-4 py-2 rounded text-blue-700 ml-2 font-bold hover:text-white mt-4 hover:bg-blue-700 lg:mt-0">
        18000000
    </a>

    <a class="block text-md px-4 py-2 rounded text-blue-700 ml-2 font-bold hover:text-white mt-4 hover:bg-blue-700 lg:mt-0">
        xyz@gmail.com
    </a>
    <div class="flex ml-auto">
        <a href="/signup" class="block text-md px-4 py-2 rounded text-blue-700 ml-2 font-bold hover:text-white mt-4 hover:bg-blue-700 lg:mt-0">
            Đăng ký
        </a>
        <a href="/login" class="block text-md px-4 ml-2 py-2 rounded text-blue-700 font-bold hover:text-white mt-4 hover:bg-blue-700 lg:mt-0">
            Đăng nhập
        </a>
    </div>
</div>
</template>

<script>
export default {
    name: 'PageHeader',

    data() {
        return {};
    },
    methods: {
        toLogin() {
            this.$router.push('/login');
        },
        toRegister() {
            this.$router.push('/signup');
        }
    }

}
</script>

<style scoped>
    
</style>
