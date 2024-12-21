<template>
  <div id="app">
    <PageLoader />
    <header v-if="showNavbar">
        <PageHeader />
        <PageNavBar :key="$route.fullPath"/>
    </header>
    <div>
      <router-view />
    </div>
    <footer v-if="!isAdminRoute && !isTest && !isLogin && !isSignup">
      <PageFooter />
    </footer>
  </div>
</template>

<script setup lang="js">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import PageHeader from "@/components/User/general/PageHeader.vue";
import PageFooter from "@/components/User/general/PageFooter.vue";
import PageNavBar from "@/components/User/general/PageNavBar.vue";
import PageLoader from "@/components/composable/PageLoader.vue";
const route = useRoute();

const isAdminRoute = computed(() => route.meta.isAdminRoute);
const isTest = computed(() => route.meta.test);
const isLogin = computed(() => route.meta.login);
const isSignup = computed(() => route.meta.signup);

const showNavbar = computed(() => (!isAdminRoute.value && !isTest.value ));
</script>

<style>
body,
html {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
  font-family: Arial, sans-serif;
}

#app {
  font-family: Montserrat, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

</style>
