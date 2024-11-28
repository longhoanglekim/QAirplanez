<template>
  <div id="container">
    <div id="wrapper">
      <form @submit.prevent="signup">
        <h3>Đăng ký tài khoản</h3>
        <div class="form-group">
          <div class="form-field">
            <input type="text" v-model="firstname" id="ho" required />
            <label class="lb-tit" for="ho">Họ</label>
          </div>
          <div class="form-field">
            <input type="text" v-model="lastname" id="ten" required />
            <label class="lb-tit" for="ten">Tên</label>
          </div>
        </div>
        <div class="form-group">
          <input type="date" v-model="birthdate"  id="birthday" required />
          <label for="" class="lb-tit" id="birthday-lb">Ngày sinh</label>
        </div>
        <div class="form-group">
          <input type="email" v-model="email" id="email" required /><label
            class="lb-tit"
            for=""
        >Email</label
        >
        </div>
        <div class="form-group">
          <input type="text" v-model="phoneNumber" id="phone" required />
          <label class="lb-tit" for="">Số điện thoại</label>
        </div>
        <div class="form-group">
          <input type="password" v-model="password" id="password" required />
          <label class="lb-tit" for="">Mật khẩu</label>
        </div>
        <div class="form-group">
          <input
              type="password"
              v-model="retypePassword"
              id="rePassword"
              required
          />
          <label class="lb-tit" for="">Nhập lại mật khẩu</label>
        </div>
        <button>Xác nhận</button>
      </form>
    <p @click="this.$route.push('/login')">
      Đã có tài khoản? <router-link to="/login">Đăng nhập</router-link>
    </p>
  </div></div>
</template>

<script scoped>
export default {
  name: 'SignUpUser',
  components: {
  },
  data() {
    return {
      firstname : '',
      lastname : '',
      birthdate : '',
      email : '',
      phoneNumber : '',
      password : '',
      retypePassword : ''
    }
  },
  methods: {
    async signup() {
      try {
        if (this.retypePassword.value !== this.password.value) {
          return;
        }
        const response = await fetch('http://localhost:8080/api/auth/register', {
          method : 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            firstname : this.firstname,
            lastname : this.lastname,
            birthdate : this.birthdate,
            email : this.email,
            phoneNumber : this.phoneNumber,
            password : this.password
          })

        });
        if (response.ok) {
          this.$route.push('/login');
        } else if (response.status === 409) {
          console.error("Email hoặc số điện thoại này đã được sử dụng!");
        } else {
          console.error("Đã xảy ra lỗi khi đăng ký.");
        }
      }
      catch (error) {
        console.log(error.message)
      }
    }
  },
  mounted() {
    document.title = 'Đăng ký tài khoản';
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
  background-image: url('@/assets/login/bg-login.jpg');
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
  max-width: 500px;
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
  border-bottom: 1px solid var(--cl-border);

}

.form-group > input {
  width: 100%;
}


.form-group input:focus,
.form-group input:hover {
  border-bottom: 2px solid var(--cl-border);
}

.lb-tit {
  background: transparent;
  position: absolute;
  left: 10px;
  top: 50%;
  transform: translateY(-50%);
  pointer-events: none;

}
.form-group input:focus + .lb-tit {
  top: -10px;
  font-size: 14px;
  font-weight: bold;
}
#birthday-lb {
  top: -10px;
  font-size: 14px;
  font-weight: bold;
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