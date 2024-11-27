<template>
  <div class="container relative">
    <div id="img">
    </div>
    <FlightSearch/>
  </div>
  
</template>

<script>
import FlightSearch from '@/components/FlightSearch.vue';
export default {
  watch: {
  },
    name: 'HomeUser',
    components: {
      FlightSearch
    }
}
</script>



<style scoped>

#img {
  height: 500px;
  background-size: cover; /* Để ảnh phủ kín div */
  background-image: url('@/assets/home/bg-home.png');
}
</style>