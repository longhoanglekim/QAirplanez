<template>
    <div>
        <div class="button-containerr">
            <button>Đăng nhập</button>
            <button>Đăng ký</button>
        </div>
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
    }
}
    
</script>

<style scoped>
    button {
        position: absolute;
        right: 0px;
    }

    .button-container:nth-child(1) {
        top: 0px;
    }
    .button-container:nth-child(2) {
        top: 50px;
    }
</style>