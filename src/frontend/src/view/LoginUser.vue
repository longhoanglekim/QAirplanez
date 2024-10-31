<template>
  <div id="wrapper">
    <form @submit.prevent="login">
      <h3>Đăng nhập</h3>
      <div class="form-group">
        <input type="email" v-model="username" id="email" required />
        <label class="lb-tit">Email hoặc số điện thoại</label>
      </div>

      <div class="form-group">
        <input type="password" v-model="password" id="password" required />
        <label class="lb-tit">Mật khẩu</label>
      </div>
      <button type="submit">Đăng nhập</button> <!-- Giữ button như bình thường -->
    </form>
    </div>
    <PageFooter/>
</template>

<script>
import PageFooter from '@/components/PageFooter.vue';
export default {
  name: 'LoginUser',
  components: {
    PageFooter
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
    }

  },
  mounted() {
    document.title = 'My login page';
    document.body.style.backgroundRepeat = "no-repeat";
    document.body.style.backgroundSize = "cover";
    //document.body.style.backgroundColor = "#080710"
    // document.body.style.backgroundImage = "url(../assets/login/bg-login.jpeg)";
  }
}
</script>

<style scoped>
* {
  box-sizing: border-box;
  --cl-border: black;
}

#wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 80vh;
  background-color: #999999;
  border-radius: 40px;
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

.form-field {
  position: relative;
  margin-right: 1rem;
}

.form-group input {
  background: transparent;
  height: 24px;
  outline: none;
  font-size: inherit;
  left: 10px;
  border: none;
  padding: 10px 0 5px;
  border-bottom: 1px solid var(--cl-border);
  transition: all 0.3s ease-in-out;
}

.form-group input:focus,
.form-group input:hover {
  border-bottom: 2px solid var(--cl-border);
}

.lb-tit {
  background: transparent;
  position: absolute;
  left: 10px;
  top: -20%;
  transform: translateY(-50%);
  pointer-events: none;
  transition: all 0.3s ease-in-out;
}

.form-group input:focus + .lb-tit {
  top: -10px;
  font-size: 14px;
  font-weight: bold;
  transition: all 0.3s ease-in-out;
}

.form-group input:valid + .lb-tit {
  top: -10px;
}
@media screen and (max-width: 768px) {
  .form-group {
    display: block;
  }
  .form-field {
    margin-bottom: inherit;
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
.social {
  margin-top: 30px;
  display: flex;
}
.social div {
  background: red;
  width: 150px;
  border-radius: 3px;
  padding: 5px 10px 10px 5px;
  background-color: rgba(255, 255, 255, 0.27);
  color: #eaf0fb;
  text-align: center;
}
.social div:hover {
  background-color: rgba(255, 255, 255, 0.47);
}
.social .fb {
  margin-left: 25px;
}
.social i {
  margin-right: 4px;
}
</style>