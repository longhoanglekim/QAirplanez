<template>
    <div class="button-container">
        <button @click="toLogin">Đăng nhập</button>
        <button @click="toRegister">Đăng ký</button>
    </div>
    <PageNavBar/>
</template>

<script>
    import PageNavBar from './PageNavBar.vue';
    export default {
        name: 'PageHeader',
        components: {
            PageNavBar
        },
        data() {
        return{};
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
    .button-container {
        position: relative;
        display: block;
        border: 1px solid black;
        background: red;
    }
    .button-container button {
        position: absolute;
        right: 0rem;
        width: 16rem;
        height: 2rem;
    }

    .button-container button:nth-child(1) {
        top: 0rem;
    }
    .button-container button:nth-child(2) {
        top: 2rem;
    }
</style>