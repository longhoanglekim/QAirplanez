<template>
  <!-- Slide -->
  <header>
    <div class="slideshow-container">
      <div
          v-for="(slide, index) in allSlides"
          :key="index"
          class="mySlides fade"
          v-show="index === currentSlide"
      >
        <img :src="'https://drive.google.com/uc?export=view&id=1DjQHk5gkHmLdhRcoppW1cuBFzbVnPXgG'" alt="Slide image" class="slide-image" />

        <button
            class="text-area"
            @mousedown="isHolding = true"
            @mouseup="isHolding = false"
            @mouseleave="isHolding = false"
            :class="{ holding: isHolding }"
        >
          <h2>{{ slide.city }}</h2>
          <p>{{ slide.description }}</p>
          <div class="location-info">
            <span>📍 {{ slide.country }}</span>
          </div>
        </button>
      </div>
    </div>

    <div class="dots-container">
      <span
          v-for="(dot, index) in allSlides"
          :key="'dot-' + index"
          class="dot"
          :class="{ active: index === currentSlide }"
          @click="setSlide(index)"
      ></span>
    </div>
  </header>
  <!-- Thanh tìm kiếm -->
  <div class="search-bar">
    <!-- Dòng chữ -->
    <label for="search-input">Bạn muốn đi đâu?</label>

    <!-- Ô nhập địa điểm -->
    <div class="search-input-container" @click.stop>
      <input
          id="search-input"
          type="text"
          placeholder="Nhập địa điểm..."
          v-model="searchQuery"
          @focus="showSuggestions = true"
          @input="filterLocations"
      />
      <transition name="fade">
        <ul
            v-if="showSuggestions && filteredLocations.length"
            class="suggestions"
        >
          <li
              v-for="(location, index) in filteredLocations"
              :key="index"
              @click="selectLocation(location)"
          >
            {{ location }}
          </li>
        </ul>
      </transition>
    </div>

    <!-- Nút tìm kiếm -->
    <button id="searchBtn" @click="handleSearch">Tìm kiếm</button>
  </div>

  <!-- Danh sách địa điểm -->
  <div class="location-cards">
    <template v-if="displayedDestinations.length">
      <button
          v-for="(destination, index) in displayedDestinations"
          :key="'card-' + index"
          class="location-card"
      >
        <a :href="'/explore/' + destination.appName" class="location-link">
          <img :src="destination.image" alt="Location Image" class="location-image" />
          <div class="location-title">
            <h3>{{ destination.title }}</h3>
          </div>
        </a>
      </button>
    </template>
    <p v-else class="no-results">Không có kết quả phù hợp.</p>
  </div>
</template>

<script>


export default {
  computed: {
  },
  data() {
    return {
      currentSlide: 0,
      isHolding: false,
      allSlides: null,
      searchQuery: "",
      filteredLocations: [],
      showSuggestions: false,
      slideInterval: null,
      destinations: [
        { appName: "Italy", title: 'Italy', image: require("@/assets/destination/1.png") },
        { appName: "Brazil", title: 'Brazil', image: require("@/assets/destination/2.png") },
        { appName: "America", title: 'America', image: require("@/assets/destination/3.png") },
        { appName:"Japan", title: 'Japan', image: require("@/assets/destination/4.png") },
        { appName: "France", title: 'France', image: require("@/assets/destination/5.png") },
        { appName: "Australia", title: 'Australia', image: require("@/assets/destination/6.png") },
      ],
      displayedDestinations: [],
    };
  },
  mounted() {
    this.downloadImage();
    this.startSlideshow();
    document.addEventListener("click", this.handleOutsideClick);
    this.resetDisplayedDestinations();
  },
  beforeUnmount() {
    document.removeEventListener("click", this.handleOutsideClick);
  },
  methods: {
    downloadImage() {
      console.log("Downloading...")
      fetch("http://localhost:8080/api/airport/public/airportList")
          .then((response) => response.json()) // Chuyển dữ liệu thành JSON
          .then((data) => {
            this.allSlides = data; // Gán dữ liệu vào allSlides
            data.forEach(dt => {

              console.log(dt.image);
            });
          })
          .catch((error) => {
            console.error("Lỗi khi lấy dữ liệu:", error); // Xử lý lỗi nếu có
          });
    },
    resetDisplayedDestinations() {
      this.displayedDestinations = [...this.destinations];
    },
    startSlideshow() {
      clearInterval(this.slideInterval);
      this.slideInterval = setInterval(() => {
        this.nextSlide();
      }, 5000);
    },
    nextSlide() {
      this.currentSlide = (this.currentSlide + 1) % this.allSlides.length;
    },
    setSlide(index) {
      this.currentSlide = index;
      this.startSlideshow();
    },
    filterLocations() {
      const query = this.searchQuery.toLowerCase();
      this.filteredLocations = this.destinations
          .map((destination) => destination.title)
          .filter((location) => location.toLowerCase().includes(query));
      this.showSuggestions = this.filteredLocations.length > 0;
    },
    selectLocation(location) {
      this.searchQuery = location;
      this.showSuggestions = false;
      this.handleSearch();
    },
    handleOutsideClick(event) {
      const searchContainer = event.target.closest(".search-bar");
      if (!searchContainer) {
        this.showSuggestions = false;

        if (!this.searchQuery.trim()) {
          this.resetDisplayedDestinations();
        }
      }
    },
    handleSearch() {
      const query = this.searchQuery.toLowerCase().trim();
      if (query) {
        this.displayedDestinations = this.destinations.filter((destination) =>
            destination.title.toLowerCase().includes(query)
        ).slice(0, 6);
      } else {
        this.resetDisplayedDestinations();
      }
      this.showSuggestions = false;
    },
  },

};
</script>


<style scoped>
@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap");

/* Slide */
header {
  width: 100vw;
  height: 100vh;
  background-color: black;
  position: relative;
  overflow: hidden;
}

.slideshow-container {
  width: 100%;
  height: 100%;
  position: relative;
}

.slide-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

.text-area {
  position: absolute;
  bottom: 20px;
  left: 20px;
  background-color: rgba(0, 0, 0, 0.6);
  color: white;
  padding: 20px;
  border-radius: 8px;
  max-width: 40%;
  font-family: "Poppins", sans-serif;
  border: none;
  cursor: pointer;
  transition: all 0.3s ease;
  outline: none;
  user-select: none;
  transform-origin: center;
}

.text-area:hover {
  background-color: rgba(255, 255, 255, 0.2);
  transform: scale(1.05);
}

.text-area:hover::after {
  opacity: 1;
}

.text-area::after {
  content: "➔";
  font-size: 20px;
  position: absolute;
  bottom: 10px;
  right: 10px;
  color: white;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.text-area.holding {
  background-color: rgba(0, 0, 0, 0.9);
  transform: scale(0.95);
}

.text-area.holding::after {
  opacity: 1;
}

.text-area h2 {
  margin: 0 0 10px;
  font-size: 28px;
}

.text-area p {
  margin: 0 0 15px;
  font-size: 16px;
}

.location-info {
  font-size: 14px;
}

.dots-container {
  position: absolute;
  bottom: 20px;
  right: 20px;
  display: flex;
  gap: 10px;
}

.dot {
  height: 12px;
  width: 12px;
  background-color: #bbb;
  border-radius: 50%;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.active {
  background-color: white;
}


/* Thanh tìm kiếm */
.search-bar {
  width: 100%;
  height: 25vh;
  margin-top: 40px;
  margin-bottom: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 40px;
  font-family: "Poppins", sans-serif;
  position: relative;
}

label {
  color: black;
  font-size: 30px;
  font-weight: 600;
  white-space: nowrap;
  margin-right: 10px;
}

.search-input-container {
  position: relative;
  width: 500px;
  margin: 0 20px;
}

input[type="text"] {
  width: 100%;
}


input {
  background-color: transparent;
  border: 2px solid rgba(0, 0, 0, 0.7);
  border-radius: 8px;
  color: black;
  font-size: 18px;
  padding: 12px 15px;
  width: 500px;
  outline: none;
  transition: all 0.3s ease;
}

input::placeholder {
  color: rgba(0, 0, 0, 0.5);
}

input:focus {
  border-color: #ff4b5c;
  box-shadow: 0 0 8px rgba(255, 75, 92, 0.7);
}

#searchBtn {
  background-color: #ff4b5c;
  border: none;
  color: white;
  font-size: 18px;
  padding: 12px 20px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  transition: background-color 0.3s ease, transform 0.2s ease;
}

#searchBtn:hover {
  background-color: #007bff;
  transform: translateY(-2px);
}

#searchBtn:active {
  transform: translateY(0);
}

/* Dropdown */
.suggestions {
  position: absolute;
  top: calc(100% + 5px);
  left: 0;
  background-color: white;
  color: black;
  border: 1px solid #ddd;
  border-radius: 8px;
  z-index: 100;
  list-style: none;
  padding: 10px 0;
  margin: 0;
  width: 100%;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.suggestions li {
  padding: 10px 15px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.suggestions li:hover {
  background-color: #f0f0f0;
}

.no-results {
  text-align: center;
  font-size: 18px;
  color: #666;
  margin-top: 20px;
}


/* Thẻ địa điểm */
.location-cards {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 20px;
  padding: 40px;
  align-items: center;
  justify-content: center;
}

.location-card {
  width: 100%;
  height: 300px;
  background-color: transparent;
  border: none;
  overflow: hidden;
  position: relative;
  transition: transform 0.3s ease;
  cursor: pointer;
  margin: auto;
}

.location-card:hover {
  transform: translateY(-5px);
}

.location-card a {
  display: block;
  width: 100%;
  height: 100%;
  text-decoration: none;
  color: inherit;
}

.location-image {
  width: 100%;
  height: 100%;
  border-radius: 8px;
}

.location-title {
  position: absolute;
  bottom: 10px;
  left: 10px;
  padding: 10px 15px;
  border-radius: 5px;
  background-color: rgb(0, 0, 0, 0.3);
}

.location-title h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: white;
}

/* Responsive Styles */
@media (max-width: 1024px) {
  .location-cards {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .location-cards {
    grid-template-columns: repeat(1, 1fr);
  }
}

.fade {
  animation-name: fade;
  animation-duration: 1.5s;
}

@keyframes fade {
  from {
    opacity: 0.4;
  }
  to {
    opacity: 1;
  }
}

/* Responsive Styles */
@media (max-width: 768px) {
  .search-bar {
    flex-direction: column; /* Các phần tử xếp theo cột */
    gap: 15px; /* Khoảng cách giữa các phần tử nhỏ hơn */
  }

  input {
    width: 100%; /* Ô input chiếm toàn bộ chiều ngang */
  }

  button {
    width: 100%; /* Nút tìm kiếm cũng chiếm toàn bộ chiều ngang */
  }

  .suggestions {
    width: 100%; /* Gợi ý chiếm toàn bộ chiều ngang */
  }
}

/* Responsive Styles */
@media (max-width: 768px) {
  .text-area {
    max-width: 90%;
    padding: 15px;
  }

  .text-area h2 {
    font-size: 22px;
  }

  .text-area p {
    font-size: 14px;
  }

  .dots-container {
    bottom: 10px;
    right: 10px;
  }

  .dot {
    height: 10px;
    width: 10px;
  }
}
</style>
