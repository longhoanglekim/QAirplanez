<template>
    <div>
        <div class="bg-white p-6 rounded-lg shadow-lg">
        <h3 class="text-lg font-bold mb-4">Thống Kê Trạng Thái Máy Bay</h3>
        
        <div class="grid grid-cols-3 gap-4">
            <!-- Active Aircraft -->
            <div class="bg-green-100 p-4 rounded-lg">
                <div class="text-green-800 font-semibold">Đang rảnh</div>
                <div class="text-2xl font-bold text-green-600">
                    {{ activeCount }}
                </div>
            </div>

            <!-- Maintenance Aircraft -->
            <div class="bg-yellow-100 p-4 rounded-lg">
                <div class="text-yellow-800 font-semibold">Được lên lịch</div>
                <div class="text-2xl font-bold text-yellow-600">
                    {{ maintenanceCount }}
                </div>
            </div>

            <!-- Inactive Aircraft -->
            <div class="bg-red-100 p-4 rounded-lg">
                <div class="text-red-800 font-semibold">Sửa chữa</div>
                <div class="text-2xl font-bold text-red-600">
                    {{ inactiveCount }}
                </div>
            </div>
        </div>
    </div>
    </div>
</template>

<script setup>
import { ref, defineProps, watchEffect } from 'vue';

const props = defineProps({
    aircraft: {
        type: Array,
        required: true
    }
})

const activeCount = ref(0)
const maintenanceCount = ref(0) 
const inactiveCount = ref(0)

// Use watchEffect to automatically track and update counts when aircraft changes
watchEffect(() => {
    activeCount.value = props.aircraft.filter(plane => plane.status === 'Active').length
    maintenanceCount.value = props.aircraft.filter(plane => plane.status === 'Maintenance').length
    inactiveCount.value = props.aircraft.filter(plane => plane.status === 'Inactive').length
})


</script>

<style scoped>
</style>
