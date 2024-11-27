<template>
  <div id="img">
  </div>
  <div class="block">
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
    background-position: center; /* Để căn giữa ảnh */
    height: 500px; /* Chiều cao của div, bạn có thể điều chỉnh theo ý muốn */
    display: flex; /* Để sử dụng flexbox bên trong */
    align-items: center; /* Căn giữa các phần tử theo chiều dọc */
    padding: 20px; /* Khoảng cách bên trong */
  background-image: url('@/assets/home/bg-home.png');
}
</style>