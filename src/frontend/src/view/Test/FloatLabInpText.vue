<template>
    <div class="relative w-full max-w-xs">
      <input 
        :id="inputId"
        v-model="inputValue"
        @change="submit"
        type="text"
        :placeholder="props.placeholder"
        class="peer w-full h-10 px-3 pt-4 border rounded-md 
               border-gray-300 
               focus:border-blue-500 
               focus:ring-1 
               focus:ring-blue-500 
               outline-none 
               transition-colors 
               placeholder-transparent"
      />
      <label 
        :for="inputId"
        class="absolute left-3 text-gray-500 
               transition-all duration-200 
               origin-left 
               peer-placeholder-shown:top-1/2 
               peer-placeholder-shown:-translate-y-1/2 
               peer-placeholder-shown:text-base 
               peer-focus:top-2 
               peer-focus:-translate-y-0 
               peer-focus:text-sm 
               peer-focus:text-blue-500"
      >
        {{ props.label }}
      </label>
    </div>
  </template>
  
  <script setup>
  import {  defineModel, defineProps, defineEmits } from 'vue'
  
  const props = defineProps({
    label: {
      type: String,
      required: true
    },
    placeholder: {
      type: String,
      default: ''
    }
  })

  const inputValue = defineModel("inputValue")
  
  const emit = defineEmits(['submit'])
  const submit = () => {
    emit('submitChild', inputValue.value)
  }

  </script>