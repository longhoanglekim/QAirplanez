<template>
<div class="bg-gray-800 min-h-screen flex items-center justify-center">
    <div class="bg-gray-900 p-4 rounded-lg shadow-lg text-white w-[600px]">
        <div class="flex items-center space-x-4">
            <!-- Loại vé -->
            <div class="flex items-center">
                <span class="mr-2">⟳</span>
                <select class="bg-gray-700 text-white px-2 py-1 rounded">
                    <option value="khứ hồi">Khứ hồi</option>
                </select>
            </div>

            <!-- Số hành khách -->
            <div class="flex items-center">
                <span class="mr-2">👤</span>
                <select class="bg-gray-700 text-white px-2 py-1 rounded">
                    <option value="1">1</option>
                </select>
            </div>

            <!-- Hạng ghế -->
            <div>
                <select class="bg-gray-700 text-white px-2 py-1 rounded">
                    <option value="phổ thông">Hạng phổ thông</option>
                </select>
            </div>
        </div>

        <!-- Nơi đi và điểm đến -->
        <div class="mt-4 grid grid-cols-2 gap-2">
            <div class="bg-gray-700 px-3 py-2 rounded flex items-center">
                <span class="mr-2">📍</span>
                <input type="text" placeholder="Hà Nội" class="bg-transparent focus:outline-none text-white w-full" />
            </div>
            <div class="bg-gray-700 px-3 py-2 rounded flex items-center">
                <span class="mr-2">📍</span>
                <input type="text" placeholder="Điểm đến?" class="bg-transparent focus:outline-none text-white w-full" />
            </div>
        </div>

        <!-- Ngày đi và ngày về -->
        <div class="mt-4 flex items-center space-x-2">
            <div class="bg-gray-700 px-3 py-2 rounded flex items-center w-full">
                <span class="mr-2">📅</span>
                <input type="date" class="bg-transparent focus:outline-none text-white w-full" />
            </div>
            <div class="bg-gray-700 px-3 py-2 rounded flex items-center w-full">
                <span class="mr-2">📅</span>
                <input type="date" class="bg-transparent focus:outline-none text-white w-full" />
            </div>
        </div>

        <!-- Nút khám phá -->
        <div class="mt-4">
            <button class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-2 rounded w-full">
                Khám phá
            </button>
        </div>
    </div>
</div>
</template>

  
  
<script>
export default {
    name: "App",
};
</script>
  
  
<style>
body {
    margin: 0;
}
</style>
