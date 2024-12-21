<script setup>
import { storeToRefs } from 'pinia'
import { useUIStore } from '@/store/UIstore'

const uiStore = useUIStore()
const { isLoading } = storeToRefs(uiStore)
</script>

<template>
  <div v-if="isLoading" class="fixedz fixed top-0 w-full h-full bg-white">
    <div class="w-fit mx-auto">
      <img src="../../assets/loading.gif" alt="">
    </div>
    
  </div>
</template>

<style scoped>
.fixedz {
  z-index: 1000000;
}
</style>