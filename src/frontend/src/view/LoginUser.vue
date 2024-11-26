<template>
  <div id="container">
    <div id="wrapper">
    <form @submit.prevent="login">
      <h3>Đăng nhập</h3>
      <div class="form-group">
        <input class="d-input" type="text" v-model="username" id="username" required />
        <label class="lb-tit">Email hoặc số điện thoại</label>
      </div>
      <div class="form-group">
        <input class="d-input" type="password" v-model="password" id="password" required />
        <label class="lb-tit">Mật khẩu</label>
      </div>
      <button type="submit">Đăng nhập</button> <!-- Giữ button như bình thường -->
    </form>
    <p @click="goToSignup">
      Chưa có tài khoản? <router-link to="/signup">Đăng ký</router-link>
    </p>
    </div>
  </div>
</template>

<script>


export default {
  name: 'LoginUser',
  components: {
  },
  data() {
    return {
      username: '',
      password: ''
    }
  },
  methods: {
    async login() {
      try {
        const response = await fetch("http://localhost:8080/api/auth/login", {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            username: this.username,
            password: this.password
          })
        });
        if (response.ok) {
          const data = await response.json();
          console.log("Token:", data.token);

          localStorage.setItem('token', data.token);
          this.$router.push({ path: '/home' });
        }
          else if (response.status === 401) {

            console.error("Sai tài khoản hoặc mật khẩu.");
          } else {

            console.error("Đã xảy ra lỗi khi đăng nhập.");
          }

      } catch (error) {
        console.error("Error:", error.message); // Log lỗi nếu có ngoại lệ xảy ra
      }
    },
    goToSignup() {
      this.$router.push('/signup');
    }
  },
  mounted() {
    document.title = 'My login page';
  }
}
</script>

<style scoped>
* {
  box-sizing: border-box;
  --cl-border: black;
  transition: all 0.3s ease-in-out;
}

#container {
  height: 150vh;
  width: 100vw;
  background-image: url('../assets/login/bg-login.jpg');
  background-size: cover;
  background-position: center;
  display: flex;
  justify-content: center;
  align-items: center;
}

#wrapper {
  background-color: rgba(255, 255, 255, 0.8);
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
  max-width: 400px;
  width: 100%;
  text-align: center;
}

h3 {
  text-align: center;
  font-size: 24px;
  margin-bottom: 50px;
}

.form-group {
  margin-bottom: 30px;
  position: relative;
  display: flex;
}

.d-input {
  height: 2.5rem;
  padding: 0 0.7rem;
}

.d-input {
  background: transparent;
  outline: none;
  font-size: inherit;
  left: 10px;
  border: none;
  padding: 10px 5px;
  border-radius: 0.5rem;
  width: 100%;
}

.d-input:focus,
.d-input:hover, .d-input:valid {
  border: 1px solid var(--cl-border);
}

.d-input:focus {
  background: white;
}

.lb-tit {
  background: transparent;
  position: absolute;
  left: 10px;
  pointer-events: none;
  top: 50%;
  transform: translateY(-50%);
}

:is(.d-input:focus, .d-input:valid) + .lb-tit {
  top: -1rem;
  font-size: 14px;
  font-weight: bold;
}

@media screen and (max-width: 768px) {
  .form-group {
    display: block;
  }
  input {
    width: 70vw;
  }
}

@media screen and (max-width: 568px) {
  input {
    width: 80vw;
  }
}

button {
  width: 100%;
  padding: 0.75rem;
  background-color: #007bff;
  border: none;
  border-radius: 4px;
  color: white;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #0056b3;
}

p {
  margin-top: 1rem;
  color: #007bff;
  cursor: pointer;
  text-decoration: underline;
}
</style>