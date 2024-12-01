<template>
    <div class="relative w-full max-w-xs">
      <input 
        :id="inputId"
        type="text"
        class="peer w-full h-10 px-3 pt-4 border rounded-md outline-none 
               focus:border-blue-500 transition-colors 
               placeholder-transparent"
        :placeholder="prop.placeholder"
        @focus="isFocused = true"
        @blur="isFocused = false"
      />
      <label 
        :for="inputId" 
        class="absolute left-3 top-2 text-gray-500 
               transition-all duration-200 
               peer-placeholder-shown:top-1/2 
               peer-placeholder-shown:-translate-y-1/2 
               peer-placeholder-shown:text-base 
               peer-focus:top-2 
               peer-focus:text-sm 
               peer-focus:text-blue-500"
      >
        {{ prop.label }}
      </label>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  import { defineProps } from 'vue';
  
  const prop = defineProps({
    label: {
      type: String,
      required: true
    },
    placeholder: {
      type: String,
      default: ''
    }
  })
  
  const inputId = `input-${Math.random().toString(36).substr(2, 9)}`
  const isFocused = ref(false)
  </script>