<template>
  <div class="container w-full bg-white">
    <div id="img" class="bg-cover bg-center"> 
    </div>
    <FlightSearch @search-flight="searchFlight" @search-ticket="searchTicket"/>
    <div>&nbsp;</div>
  </div>
</template>

<script setup>
import FlightSearch from '@/components/User/FlightSearch.vue';
import {searchTicket} from "@/store/searchTicket";

</script>

<script>
export default {
  methods: {
    searchFlight() {
      this.$router.push('/booking/availability/0')
    }
  },
  name: 'HomeUser'
}
</script>


<style scoped>

#img {
  height: 500px;
  background-size: cover; /* Để ảnh phủ kín div */
  background-image: url('@/assets/home/bg-home.png');
}
</style>