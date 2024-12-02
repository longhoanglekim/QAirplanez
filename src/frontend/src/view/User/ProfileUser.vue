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
          { id: "dashboard", label: "Dashboard" },
          { id: "bookings", label: "My Bookings" },
          { id: "profile", label: "My Profile" },
        ],
        selectedMenu: "dashboard",
        avatarUrl: "https://via.placeholder.com/150",
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
  <div id="bg_img">
  </div>
  <div class="container">
    <div class="side-bar">
      <!-- Avatar -->
      <div class="avatar-section">
        <img :src="avatarUrl" alt="User Avatar" class="avatar" />
        <button @click="triggerFileUpload">Change Avatar</button>
        <input
            type="file"
            ref="fileInput"
            accept="image/*"
            @change="handleAvatarChange"
            style="display: none;"
        />
      </div>
    <!-- Menu -->
    <nav class="menu">
      <ul>
        <li
            v-for="item in menuItems"
            :key="item.id"
            :class="{ active: selectedMenu === item.id }"
            @click="selectMenu(item.id)"
        >
          {{ item.label }}
        </li>
      </ul>
    </nav>
    </div>
    <!-- Content Box -->
    <div class="content-box">
      <div v-show="selectedMenu === 'dashboard'">
        <MyDashBoard/>
      </div>
      <div v-show="selectedMenu === 'bookings'">
        <MyBookings/>
      </div>
      <div v-show="selectedMenu === 'profile'">
        <MyProfile/>
      </div>
    </div>
  </div>
</template>

<style scoped>
.container {
  margin-top: 40px;
  display: flex;
  font-family: Arial, sans-serif;
}

#bg_img {
  height: 500px;
  background-size: cover;
  background-image: url('@/assets/home/bg-home.png');
}

/* Sidebar menu */
.side-bar {
  width: 20%;
  padding: 1rem;
  background-color: #f4f4f4;
  border-right: 1px solid #ddd;
  align-items: center;
}

/* Avatar Section */
.avatar {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 1rem;
}

.avatar-section {
  text-align: center;
  margin-bottom: 2rem; /* Khoảng cách dưới */
  display: flex; /* Sử dụng Flexbox */
  flex-direction: column; /* Sắp xếp các phần tử theo cột */
  align-items: center; /* Căn giữa theo chiều ngang */
}

.avatar-section button {
  background-color: #007bff;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.avatar-section button:hover {
  background-color: #0056b3;
}

.menu ul {
  list-style: none;
  padding: 0;
}

.menu li {
  padding: 0.5rem 1rem;
  cursor: pointer;
  border-radius: 5px;
  margin-bottom: 0.5rem;
  text-align: left;
  transition: background-color 0.3s;
}

.menu li:hover {
  background-color: #e0e0e0;
}

.menu li.active {
  background-color: #007bff;
  color: white;
  font-weight: bold;
}

/* Content Box */
.content-box {
  width: 80%;
  padding: 1.5rem;
}

.content-box h2 {
  color: #333;
}

.content-box p {
  color: #666;
  line-height: 1.5;
}
</style>