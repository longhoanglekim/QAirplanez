<template>
  <div id="app">
    <header><PageHeader/></header>
    <router-view></router-view>
    <footer><PageFooter/></footer>
  </div>

</template>

<script>

import PageHeader from "@/components/PageHeader.vue";
import PageFooter from "@/components/PageFooter.vue";

export default {
  name: 'App',
  components: {PageFooter, PageHeader},

  data() {
    return {
    };
  }
}
</script>

<style>

body, html {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
  font-family: Arial, sans-serif;
  background-image: url('@/assets/home/bg-home.png');
  background-size: cover;
  background-repeat: no-repeat;
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}


</style>
