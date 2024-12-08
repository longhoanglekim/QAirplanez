<script>
  import MyProfile from "@/components/User/profileUser/Profile.vue";
  import MyDashBoard from "@/components/User/profileUser/Dashboard.vue";
  import MyBookings from "@/components/User/profileUser/Bookings.vue";
  export default {
    name: 'ProfileUser',
    components: {
      MyBookings,
      MyDashBoard,
      MyProfile,
    },
    data() {
      return {
        menuItems: [
          { id: "dashboard", label: "Dashboard", icon: require("@/assets/icon/layout.png") },
          { id: "bookings", label: "Bookings", icon: require("@/assets/icon/time.png") },
          { id: "profile", label: "Profile", icon: require("@/assets/icon/user.png") },
        ],
        selectedMenu: "dashboard",
        avatarUrl: "https://via.placeholder.com/100",
      };
    },
    methods: {
      selectMenu(menuId) {
        this.selectedMenu = menuId;
      },
      triggerFileUpload() {
        this.$refs.fileInput.click();
      },
      handleAvatarChange(event) {
        const file = event.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = (e) => {
            this.avatarUrl = e.target.result; // Update avatarUrl with new image
          };
          reader.readAsDataURL(file); // Convert image to base64
        }
      },
    },
  }
</script>

<template>
  <div
      class="flex min-h-screen bg-orange-100 py-20"
      :style="{ backgroundImage: `url('background-image-url.jpg')`, backgroundSize: 'cover', backgroundPosition: 'center' }"
  >
    <!-- Sidebar -->
    <div class="sticky top-20 self-start w-1/4 bg-white shadow-xl rounded-2xl p-6 mx-6">
      <!-- Sidebar Content -->
      <div class="text-center mb-8">
        <!-- Avatar Section -->
        <div class="relative group">
          <img
              :src="avatarUrl"
              alt="User Avatar"
              class="w-24 h-24 rounded-full border-4 border-orange-300 mb-4 shadow-lg mx-auto transition-transform transform group-hover:scale-105"
          />
          <p
              class="text-sm text-orange-500 mt-2 cursor-pointer hover:underline transition"
              @click="triggerFileUpload"
          >
            Đổi ảnh đại diện
          </p>
        </div>
        <input
            type="file"
            ref="fileInput"
            accept="image/*"
            @change="handleAvatarChange"
            class="hidden"
        />
      </div>

      <!-- Navigation Menu -->
      <nav>
        <ul class="space-y-4">
          <li
              v-for="item in menuItems"
              :key="item.id"
              class="flex items-center px-4 py-3 rounded-lg cursor-pointer hover:bg-orange-200 transition-all"
              :class="{
              'bg-orange-500 text-white': selectedMenu === item.id,
              'text-gray-700': selectedMenu !== item.id
            }"
              @click="selectMenu(item.id)"
          >
            <img :src="item.icon" alt="Menu Icon" class="w-6 h-6 mr-3" />
            <span class="font-medium">{{ item.label }}</span>
          </li>
        </ul>
      </nav>
    </div>

    <!-- Content Box -->
    <div class="flex-1 bg-white shadow-xl rounded-2xl p-8 mx-6">
      <div class="prose prose-orange">
        <!-- Dynamic Content -->
        <div v-show="selectedMenu === 'dashboard'" class="animate-fade-in">
          <MyDashBoard />
        </div>
        <div v-show="selectedMenu === 'bookings'" class="animate-fade-in">
          <MyBookings />
        </div>
        <div v-show="selectedMenu === 'profile'" class="animate-fade-in">
          <MyProfile />
        </div>
      </div>
    </div>
  </div>
</template>


<style scoped>

@keyframes fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.animate-fade-in {
  animation: fade-in 0.5s ease-in-out;
}
</style>
