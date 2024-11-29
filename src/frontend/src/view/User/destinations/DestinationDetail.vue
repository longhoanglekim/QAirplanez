<template>
  <div>
    <h1>Thông tin về {{ destination }}</h1>
    <img :src="destinationData.image" alt="Destination Image" v-if="destinationData" />
    <p v-if="destinationData">{{ destinationData.description }}</p>
    <router-link to="/">Quay lại trang chính</router-link>
  </div>
</template>

<script>
export default {
  name: 'DestinationView',
  props: ['destination'],
  data() {
    return {
      destinations: [
        {
            title: 'Italy',
            image: require('@/assets/destination/1.png'),
          description: 'Đất nước nổi tiếng với nền văn hóa La Mã.',
        },
        {
          title: 'Brazil',
          image: require('@/assets/destination/2.png'),
          description: 'Vùng đất của lễ hội carnival rực rỡ.',
        },
      ],
    };
  },
  computed: {
    destinationData() {
      return this.destinations.find(
          (dest) => dest.title.toLowerCase() === this.destination.toLowerCase()
      );
    },
  },
};
</script>

<style scoped>
img {
  width: 100%;
  height: auto;
  margin-top: 20px;
}
</style>
