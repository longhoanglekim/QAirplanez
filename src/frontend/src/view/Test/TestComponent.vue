<script setup>
import { authStore } from '@/store';



const store = authStore()


</script>

<template>
    <div>{{ store.user.role }}</div>
    
    <div id="showInput">hello</div>
</template>

<style>
    
</style>