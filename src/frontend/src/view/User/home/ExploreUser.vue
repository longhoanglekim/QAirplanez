<template>
  <div class="explore-user">
    <header>
      <div class="slideshow-container">
        <div
            v-for="(slide, index) in allSlides"
            :key="index"
            class="mySlides fade"
            v-show="index === currentSlide"
        >
          <img :src="slide.image" alt="Slide image" class="slide-image" />

          <button
              class="text-area"
              @mousedown="isHolding = true"
              @mouseup="isHolding = false"
              @mouseleave="isHolding = false"
              :class="{ holding: isHolding }"
          >
            <h2>{{ slide.title }}</h2>
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
        <div
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
        </div>
      </template>
    </div>
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
      allSlides: [
        {
          image: require("@/assets/destination/danang.jpg"),
          title: "Đà Nẵng",
          description:
              "Đến với Đà Nẵng để mê mẩn trước những bãi cát trắng, đắm mình giữa làn nước xanh dưới cái nắng vàng ươm.",
          location: "Việt Nam",
        },
        {
          image: require("@/assets/destination/hanoi.jpg"),
          title: "Hà Nội",
          description:
              "Khám phá thủ đô với vẻ đẹp cổ kính và những di tích lịch sử độc đáo.",
          location: "Việt Nam",
        },
        {
          image: require("@/assets/destination/bangkok.jpg"),
          title: "Bangkok",
          description:
              "Khám phá thành phố sôi động với các ngôi chùa và món ăn đường phố tuyệt vời.",
          location: "Thái Lan",
        },
      ],
      searchQuery: "",
      filteredLocations: [],
      showSuggestions: false,
      slideInterval: null,
      destinations: [
        { appName: "Italy", title: 'Italy', image: require("@/assets/destination/italy.jpg") },
        { appName: "Brazil", title: 'Brazil', image: require("@/assets/destination/brazil.jpg") },
        { appName: "America", title: 'America', image: require("@/assets/destination/america.jpg") },
        { appName:"Japan", title: 'Japan', image: require("@/assets/destination/japan.jpg") },
        { appName: "France", title: 'France', image: require("@/assets/destination/france.jpg") },
        { appName: "Australia", title: 'Australia', image: require("@/assets/destination/australia.jpg") },
        { appName: "Spain", title: 'Spain', image: require("@/assets/destination/spain.jpg") },
        { appName: "Germany", title: 'Germany', image: require("@/assets/destination/germany.jpg") },
        { appName: "Canada", title: 'Canada', image: require("@/assets/destination/canada.jpg") },
        { appName: "China", title: 'China', image: require("@/assets/destination/china.jpg") },
      ],
      displayedDestinations: [],
    };
  },
  mounted() {
    document.title = 'Khám phá';
    this.startSlideshow();
    document.addEventListener("click", this.handleOutsideClick);
    this.resetDisplayedDestinations();
  },
  beforeUnmount() {
    document.removeEventListener("click", this.handleOutsideClick);
  },
  methods: {
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
  width: 100%;
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
  margin-left: 10px;
  margin-right: 10px;
  gap: 10px;
  display: flex;
  overflow-x: auto;
  white-space: nowrap;
  scrollbar-width: thin; /* Firefox */
  scrollbar-color: gray transparent; /* Firefox */
}

.location-cards::-webkit-scrollbar {
  height: 8px; /* Reduce height */
}

.location-cards::-webkit-scrollbar-track {
  background: transparent;
}

.location-cards::-webkit-scrollbar-thumb {
  background-color: gray; /* Change color to gray */
  border-radius: 10px;
}

.location-card {
  background-color: white;
  flex: 0 0 300px; /* Increase width */
  height: 200px; /* Increase height */
  margin-right: 10px;
  margin-bottom: 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  box-sizing: border-box;
  transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth hover animation */
}

.location-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.location-card a {
  display: block;
  text-decoration: none;
  color: inherit;
}

.location-image {
  width: 100%;
  height: 70%;
  object-fit: cover;
}

.location-title {
  height: 30%;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.location-title h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

/* Reduce the size of the slider and change its color to gray */
.slider {
  height: 10px; /* Reduce height */
  background-color: gray; /* Change color to gray */
  border-radius: 5px;
  margin-top: 20px;
}

/* Responsive Styles */
@media (max-width: 1024px) {
  .location-cards {
    flex-direction: column;
    align-items: center;
  }

  .location-card {
    flex: 0 0 200px; /* Adjust width for smaller screens */
    height: 300px; /* Adjust height for smaller screens */
  }
}

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

  .explore-user .location-card {
    flex: 0 0 150px; /* Adjust width for smaller screens */
    height: 250px; /* Adjust height for smaller screens */
  }
}

.explore-user .location-cards {
  display: flex;
  overflow-x: auto;
  white-space: nowrap;
}

.explore-user .location-card {
  flex: 0 0 200px; /* Fixed width for each card */
  height: 300px; /* Fixed height for each card */
  margin-right: 10px; /* Space between cards */
  display: flex;
  flex-direction: column;
  align-items: center;
  border-radius: 10px;
  justify-content: center;
  box-sizing: border-box;
}

.explore-user .location-link {
  display: block;
  width: 100%;
  height: 100%;
  text-align: center;
}

.explore-user .location-image {
  width: 100%;
  height: 70%; /* Adjust the height as needed */
  border-radius: 10px 10px 0 0; /* Rounded corners on top */
  object-fit: cover; /* Ensure the image covers the area */
}

.explore-user .location-title {
  height: 30%; /* Adjust the height as needed */
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

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

  .explore-user .location-card {
    flex: 0 0 150px; /* Adjust width for smaller screens */
    height: 250px; /* Adjust height for smaller screens */
  }
}
</style>
