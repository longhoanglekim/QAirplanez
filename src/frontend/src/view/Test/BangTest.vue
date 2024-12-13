<template>
    <div>
      <button 
        v-for="(day, index) in calendarDays" 
        :key="index" 
        @mouseover="() => handleMouseOver()"
        @click="() => handleDateClick(day)"
        
      >
        {{ day.day }}
      </button>
      <p>Selected Date: {{ selectedDate }}</p>
    </div>
  </template>
  
  <script setup>
  import { ref, computed } from 'vue'
  
  const selectedDate = ref(null)
  
  const calendarDays = computed(() => [
    { day: 1, current: true, disabled: false },
    { day: 2, current: true, disabled: false }
  ])
  const handleMouseOver = () => {
    console.log('Mouseover')
  }
  const handleDateClick = (day) => {
    console.log('Date clicked:', day)
    if (day.current && !day.disabled) {
      selectedDate.value = day.date || new Date(2024, 0, day.day)
      console.log('Selected date:', selectedDate.value)
    }
  }
  </script>