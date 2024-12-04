<script setup>
import {
    ref
} from 'vue'

const items = ref([{
        title: 'Mục 1',
        content: 'Nội dung chi tiết của mục 1 sẽ được hiển thị ở đây.'
    },
    {
        title: 'Mục 2',
        content: 'Nội dung chi tiết của mục 2 sẽ được hiển thị ở đây.'
    },
    {
        title: 'Mục 3',
        content: 'Nội dung chi tiết của mục 3 sẽ được hiển thị ở đây.'
    }
])

const activeIndex = ref(null)

const toggleAccordion = (index) => {
    if (activeIndex.value === index) {
        activeIndex.value = null
    } else {
        activeIndex.value = index
    }
}
</script>

<template>
<div class="w-full max-w-md mx-auto">
    <div v-for="(item, index) in items" :key="index" class="border rounded-lg mb-2 overflow-hidden">
        <div @click="toggleAccordion(index)" class="bg-gray-100 p-4 cursor-pointer flex justify-between items-center hover:bg-gray-200 transition-colors">
            <h3 class="font-semibold">{{ item.title }}</h3>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 transform transition-transform duration-300" :class="activeIndex === index ? 'rotate-180' : ''" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
        </div>

        <div class="transition-all duration-300 ease-in-out overflow-hidden" :class="activeIndex === index 
          ? 'max-h-screen opacity-100 p-4' 
          : 'max-h-0 opacity-0 p-0'">
            <p class="text-gray-600">{{ item.content }}</p>
        </div>
    </div>
</div>
</template>
