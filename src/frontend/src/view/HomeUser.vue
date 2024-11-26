<script>
import FlightSearch from '@/components/FlightSearch.vue';
export default {
    name: 'HomeUser',
    components: {
      FlightSearch
    }
}
</script>

<template>
  <div class="img-container">
  </div>
  <div>
    <FlightSearch/>
  </div>
  <div>aaa</div>
</template>
<style scoped>
.img-container {
  color: #333366;
  height: 200px;
  float: top;
}
</style>