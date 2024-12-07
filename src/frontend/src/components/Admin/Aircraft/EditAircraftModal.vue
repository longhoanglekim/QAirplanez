<template>
    <div v-if="isModalOpen" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg w-1/2">
            <h3 class="text-lg font-bold mb-4">{{ isEditing ? 'Chỉnh Sửa' : 'Thêm' }} Máy Bay</h3>
            <div class="space-y-4">
                <input v-model="currentAircraft.id" placeholder="Mã Máy Bay" class="w-full p-2 border rounded" :disabled="isEditing" />
                <input v-model="currentAircraft.model" placeholder="Mô Hình" class="w-full p-2 border rounded" />
                <input v-model.number="currentAircraft.capacity" type="number" placeholder="Sức Chứa" class="w-full p-2 border rounded" />
                <select v-model="currentAircraft.status" class="w-full p-2 border rounded">
                    <option>Active</option>
                    <option>Maintenance</option>
                    <option>Inactive</option>
                </select>
                <div class="flex justify-end space-x-2">
                    <button @click="closeModal" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
                    <button @click="saveAircraft" class="bg-blue-500 text-white p-2 rounded">Lưu</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, defineProps, defineEmits } from 'vue';

const props = defineProps({
    isModalOpen: {
        type: Boolean,
        required: true
    },
    currentAircraft: {
        type: Object,
        required: true
    }
})
const emit = defineEmits(['close', 'save']);

const closeModal = () => {
    emit('close');
}

const saveAircraft = () => {
    emit('save', currentAircraft.value);
}
</script>

<style lang="scss" scoped>

</style>