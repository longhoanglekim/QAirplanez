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
</template>
<style>
.img-container {
  height: 150px;
  color: #333366;

}
</style>