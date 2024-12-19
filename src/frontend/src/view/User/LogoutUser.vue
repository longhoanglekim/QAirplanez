<script setup>
import {onMounted} from "vue";
onMounted(() => {
      document.title = 'Đăng xuất';
      localStorage.removeItem('token');
  }

)

</script>

<template>
  <p class="mt-10">Loading</p>
</template>

<style scoped>

</style>