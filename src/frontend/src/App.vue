<template>
  <div id="app">
    <header><PageHeader/></header>
    <PageNavBar/>
    <router-view></router-view>
    <footer><PageFooter/></footer>
  </div>

</template>

<script>

import PageHeader from "@/components/PageHeader.vue";
import PageFooter from "@/components/PageFooter.vue";
import PageNavBar from "./components/PageNavBar.vue";

export default {
  name: 'App',
  components: {PageFooter, PageHeader, PageNavBar},

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
  /* display: flex;
  justify-content: center;
  align-items: center; */
}

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background: #2c3e50;
  text-align: center;
}
footer {
  font-family: "Rubik", sans-serif;
  background-color: rgb(255, 242, 242);
  margin-top: 0;
  padding-top: 1px;
}
.d-input {
  background: transparent;
  outline: none;
  font-size: inherit;
  left: 10px;
  border: none;
  padding: 10px 5px;
  border-radius: 0.5rem;
  width: 100%;
}

.d-input:focus,
.d-input:hover, .d-input:valid {
  border: 1px solid var(--cl-border);
}

.d-input:focus {
  background: white;
}

.lb-tit {
  background: transparent;
  position: absolute;
  left: 10px;
  pointer-events: none;
  top: 50%;
  transform: translateY(-50%);
}

:is(.d-input:focus, .d-input:valid) + .lb-tit {
  top: -1rem;
  font-size: 14px;
  font-weight: bold;
}
</style>
