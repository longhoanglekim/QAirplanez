<template>
    <div class="flight-search-result">
      <h2>Flight Search Results</h2>
      <div v-if="flights.length === 0">No flights found.</div>
      <div v-else>
        <TicketCard
          v-for="(flight, index) in flights"
          :key="index"
          :departure="flight.departure"
          :arrival="flight.arrival"
        />
      </div>
    </div>
  </template>
  
  <script>
  import TicketCard from '@/components/TicketCard.vue';
  
  export default {
    components: {
      TicketCard
    },
    data() {
      return {
        // TO DO
        // cần lay tu csdl
        flights: [
          {
            departure: { cityCode: 'HCM', time: '2024-11-20 08:00' },
            arrival: { cityCode: 'HN', time: '2024-11-20 10:00' }
          },
          {
            departure: { cityCode: 'SGN', time: '2024-11-21 14:00' },
            arrival: { cityCode: 'DAD', time: '2024-11-21 16:30' }
          }
        ]
      };
    }
  };
  </script>
  
  <style scoped>
  .flight-search-result {
    padding: 20px;
  }
  </style>
  