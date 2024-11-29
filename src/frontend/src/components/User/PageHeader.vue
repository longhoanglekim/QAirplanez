<template>
    
<div class="sticky">aaaa</div>
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
