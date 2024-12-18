<template>
<div id="app">
    <header v-if="!isAdminRoute && !isTest">
        <PageHeader />
        <PageNavBar :key="$route.fullPath"/>
    </header>

    <router-view></router-view>
    <footer v-if="!isAdminRoute && !isTest">
        <PageFooter />
    </footer>
</div>
</template>

<script>
import PageHeader from "@/components/User/general/PageHeader.vue";
import PageFooter from "@/components/User/general/PageFooter.vue";
import PageNavBar from "@/components/User/general/PageNavBar.vue";

export default {
    name: 'App',
    components: {
        PageFooter,
        PageHeader,
        PageNavBar
    },
    computed: {
        isAdminRoute() {
            return this.$route.meta.isAdminRoute;
        },
        isTest() {
            return this.$route.meta.test;
        }
    },

    data() {
        return {};
    }
}
</script>

<style>
body,
html {
    margin: 0;
    padding: 0;
    height: 100%;
    width: 100%;
    font-family: Arial, sans-serif;
    /* display: flex;
  justify-content: center;
  align-items: center; */
}

#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
}

footer {
    font-family: "Rubik", sans-serif;
    background-color: rgb(255, 242, 242);
    margin-top: 0;
    padding-top: 1px;
}
</style>
