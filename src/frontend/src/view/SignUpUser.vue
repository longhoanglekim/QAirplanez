<template>
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
          <input type="text" v-model="birthdate"  id="birthday" required />
          <label for="" class="lb-tit">Ngày sinh</label>
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
        <button>xac nhan</button>
      </form>
    </div>
    <PageFooter/>
</template>


<script scoped>
import PageFooter from '@/components/PageFooter.vue';
export default {
    name: 'SignUpUser',
    components: {
      PageFooter
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
            birthdate : new Date('2024-10-31T00:00:00'),
            email : this.email,
            phoneNumber : this.phoneNumber,
            password : this.password
          })

        });
        if (response.ok) {
          this.$router.push({path : '/login'});
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
    document.body.style.backgroundColor = '#080710'
  }
}
</script>

<style>
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
  top: 50%;
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

</style>