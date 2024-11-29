<template>
  <div class="container w-full">
    <div id="img" class="bg-cover bg-center"> 
    </div>
    <FlightSearch/>
  </div>
  
</template>

<script>
import FlightSearch from '@/components/User/FlightSearch.vue';
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