<template>
  <div class="container">
    <div style="margin-top: 200px;">
      <form @submit.prevent="login" id="loginForm">
        <table>
          <tbody>
          <tr>
            <td>Enter the account:</td>
            <td><input type="text" v-model="username" required="required"></td>
          </tr>
          <tr>
            <td>Enter the password:</td>
            <td><input type="password" v-model="password" required="required"></td>
          </tr>
          <tr>
            <td>
              <input type="submit" value="Login" class="button-green">
              <p>Or login with admin account
                <router-link id="adminLink" to="/login_admin"> Here</router-link>
              </p>
            </td>

          </tr>
          </tbody>

        </table>
        <input type="hidden" id="token" value="">
      </form>
    </div>
    <p>Haven't got an account? <span></span></p>
  </div>
</template>

<script>
export default {
  name: 'LoginUser',
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

        // Log the response to see what is returned
        console.log(response);

        if (response.status === 401) {
          throw new Error("Invalid credentials");
        } else if (!response.ok) {
          throw new Error("Login error");
        } else {
          // Try to parse the response as JSON
          const data = await response.json();
          console.log("Token: " + data.token);

          localStorage.setItem('token', data.token);
          this.$router.push({path : '/welcome'});
        }

      } catch (error) {
        console.error(error);
      }
    }

  },
  mounted() {
    document.title = 'My login page';
  }
}
</script>

<style scoped>
.button-green {
  background-color: #04AA6D;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 10px;
}

.button-green:hover {
  background-color: darkgreen;
  color: white;
}

#register-link {
  background-color: steelblue;
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 10px;
}

#register-link:hover {
  background-color: #0a58ca;
}

#adminLink {
  margin-left: 5px;
}
</style>