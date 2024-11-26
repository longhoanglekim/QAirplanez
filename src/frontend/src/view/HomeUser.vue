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
  <div id="img">
  </div>
  <div>
    <FlightSearch/>
  </div>
  
</template>
<style scoped>
#img {
  color: #333366;
  height: 200px;
  float: top;
  border: 1px solid white;
}
</style>