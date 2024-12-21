import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useUIStore = defineStore('UIStore', () => {
  const isLoading = ref(false)
  return {
    isLoading,
  }
})