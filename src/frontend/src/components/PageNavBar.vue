<template>
    <div class="header">
      <a class="logo"><p>
        <img src="@/assets/home/logo.jpg" alt="Background Image">
      </p></a>
      <nav class="navBar">
          <a href="#">Khám phá</a>
          <a href="#">Đặt vé</a>
          <a href="#">Thông tin hành trình</a>
          <a href="#">QAirline Club</a>
      </nav>
      <div class="ref-links">Something</div>
    </div>


</template>

<script>
export default {
    name: 'PageNavBar'
}
</script>
<style scoped>
  .header {
    width: 100%;
    display : flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
    gap : 20px;
    margin-bottom: 20px;
    background : transparent;
    padding-bottom: 5px;
    padding-top : 5px;
  }
  .navBar {
    display : flex;
    gap : 20px;

  }
  .navBar a {
    font-size : 18px;
    color : #fff;
    font-weight: 500;
    text-decoration: none ;
    position : relative;
  }
  .navBar a::before {
    content : '';
    top : 100%;
    position : absolute;
    left : 0;
    width : 100%;
    height : 2px;
    background : #fff;
  }
  .logo {
    width : 25%;
  }
  .ref-links {
    width : 25%;
  }
  img {
    width : 50px;
    height : 50px;
  }
</style>