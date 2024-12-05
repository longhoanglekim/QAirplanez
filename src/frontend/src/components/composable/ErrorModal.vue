<template>
<div v-if="modelValue" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50">
    <div class="bg-white w-96 rounded-lg shadow-2xl border-2 border-orange-500 overflow-hidden">
        <div class="bg-gradient-to-r from-red-500 to-orange-500 p-4 flex items-center justify-between">
            <div class="flex items-center space-x-2">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z" />
                    <path d="M12 9v4" />
                    <path d="M12 17h.01" />
                </svg>
                <h2 class="text-white font-bold text-lg">{{ title }}</h2>
            </div>
            <button @click="closeModal" class="text-white hover:bg-red-600 rounded-full p-1 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="18" y1="6" x2="6" y2="18" />
                    <line x1="6" y1="6" x2="18" y2="18" />
                </svg>
            </button>
        </div>

        <div class="p-6 bg-orange-50">
            <p class="text-gray-700 mb-6">{{ message }}</p>
            <slot></slot>
            <div class="flex justify-end">
                <button @click="closeModal" class="px-4 py-2 bg-gradient-to-r from-red-500 to-orange-500 text-white rounded-md hover:from-red-600 hover:to-orange-600 transition-all">
                    {{ actionText }}
                </button>
            </div>
        </div>
    </div>
</div>
</template>

  
  
<script>
export default {
    name: 'ErrorModal',
    props: {
        modelValue: {
            type: Boolean,
            default: true
        },
        title: {
            type: String,
            default: 'Đã xảy ra lỗi'
        },
        message: {
            type: String,
            default: 'Có vấn đề xảy ra. Vui lòng thử lại sau.'
        },
        actionText: {
            type: String,
            default: 'Đóng'
        }
    },
    methods: {
        closeModal() {
            this.$emit('update:modelValue', false)
        }
    }
}
</script>
