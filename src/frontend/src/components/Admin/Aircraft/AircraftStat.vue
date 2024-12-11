<template>
    <div>
        <div class="bg-white p-6 rounded-lg shadow-lg">
        <h3 class="text-lg font-bold mb-4">Thống Kê Trạng Thái Máy Bay</h3>
        
        <div class="grid grid-cols-3 gap-4">
            <!-- Active Aircraft -->
            <div class="bg-green-100 p-4 rounded-lg">
                <div class="text-green-800 font-semibold">Đang Hoạt Động</div>
                <div class="text-2xl font-bold text-green-600">
                    {{ activeCount }}
                </div>
            </div>

            <!-- Maintenance Aircraft -->
            <div class="bg-yellow-100 p-4 rounded-lg">
                <div class="text-yellow-800 font-semibold">Đang Bảo Trì</div>
                <div class="text-2xl font-bold text-yellow-600">
                    {{ maintenanceCount }}
                </div>
            </div>

            <!-- Inactive Aircraft -->
            <div class="bg-red-100 p-4 rounded-lg">
                <div class="text-red-800 font-semibold">Không Hoạt Động</div>
                <div class="text-2xl font-bold text-red-600">
                    {{ inactiveCount }}
                </div>
            </div>
        </div>
    </div>
    <!-- Pie Chart -->
    <div class="mt-8">
        <h4 class="text-lg font-semibold mb-4">Biểu Đồ Phân Bố Trạng Thái Tàu Bay</h4>
        <div class="w-full h-64 relative">
            <canvas ref="pieChart">

            </canvas>
        </div>
        
        <!-- Legend -->
        <div class="flex justify-center mt-4 gap-6">
            <div class="flex items-center">
                <div class="w-4 h-4 bg-green-500 rounded-full mr-2"></div>
                <span>Đang Hoạt Động</span>
            </div>
            <div class="flex items-center">
                <div class="w-4 h-4 bg-yellow-500 rounded-full mr-2"></div>
                <span>Đang Bảo Trì</span>
            </div>
            <div class="flex items-center">
                <div class="w-4 h-4 bg-red-500 rounded-full mr-2"></div>
                <span>Không Hoạt Động</span>
            </div>
            </div>
        </div>
    </div>
</template>

<script setup>

import { computed, ref } from 'vue';
import { aircraft } from '../../../assets/data';

const activeCount = computed(() => {
    return aircraft.filter(plane => plane.status === 'Hoat dong').length;

});

const maintenanceCount = computed(() => {
    return aircraft.filter(plane => plane.status === 'Bao duong').length;
});

const inactiveCount = computed(() => {
    return aircraft.filter(plane => plane.status === 'Sua chua').length;
});
const pieChart = ref(null);
</script>

<style scoped>
</style>
