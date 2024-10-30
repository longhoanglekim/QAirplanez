<script>
import PageNavBar from '@/components/PageNavBar.vue';
import PageFooter from '@/components/PageFooter.vue';
export default {
    name: 'HomeUser',
    components: {
        PageFooter,
        PageNavBar
    }
}
</script>

<template>
    <PageNavBar/>
    <div>Home user</div>
    <PageFooter/>
</template>
