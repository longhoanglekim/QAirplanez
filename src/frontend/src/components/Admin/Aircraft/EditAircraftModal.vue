<template>
    <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white p-6 rounded-lg w-1/2">
            <h3 class="text-lg font-bold mb-4">Chỉnh Sửa Máy Bay</h3>
            <div class="space-y-4">
                <div class="flex flex-col">
                    <label class="mb-1">Nhà sản xuất</label>
                    <input
                        v-model="editedAircraft.manufacturer"
                        placeholder="Nhà sản xuất"
                        class="w-full p-2 border rounded"
                    />
                </div>

                <div class="flex flex-col">
                    <label class="mb-1">Model</label>
                    <input
                        v-model="editedAircraft.model"
                        placeholder="Model máy bay"
                        class="w-full p-2 border rounded"
                    />
                </div>

                <div class="flex flex-col">
                    <label class="mb-1">Số ghế</label>
                    <input
                        v-model.number="editedAircraft.numberOfSeats"
                        type="number"
                        placeholder="Số ghế"
                        class="w-full p-2 border rounded"
                        min="1"
                    />
                </div>

                <div class="flex flex-col">
                    <label class="mb-1">Trạng thái</label>
                    <select v-model="editedAircraft.status" class="w-full p-2 border rounded">
                        <option value="Active">Đang rảnh</option>
                        <option value="Maintenance">Được lên lịch</option>
                        <option value="Inactive">Sửa chữa</option>
                    </select>
                </div>

                <div class="flex justify-end space-x-2">
                    <button @click="closeModal" class="bg-gray-500 text-white p-2 rounded">Hủy</button>
                    <button @click="saveAircraft" class="bg-blue-500 text-white p-2 rounded">Lưu</button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, watch, defineProps, defineEmits } from 'vue'

const props = defineProps({
    currentAircraft: {
        type: Object,
    }
})

const emit = defineEmits(['close', 'save'])

const editedAircraft = ref({ ...props.currentAircraft })

watch(() => props.currentAircraft, (newVal) => {
    editedAircraft.value = { ...newVal }
}, { deep: true })

const closeModal = () => {
    emit('close')
}

const saveAircraft = () => {
    emit('save', editedAircraft.value)
}
</script>

<style scoped>

</style>