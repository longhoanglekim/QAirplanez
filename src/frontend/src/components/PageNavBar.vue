<template>
    <div class="header">
      <a class="logo"><p>
        <img src="@/assets/home/logo.jpg" alt="Background Image">
      </p></a>
      <nav class="navBar">
        <ul class="navMenu">
          <li>
            <a href="#">Khám phá</a>
            <div>
              <ul>
                <li><a href="">Hello 1</a></li>
                <li><a href=""> Hello 2</a></li>
                <li><a href="">Hello 3</a></li>
              </ul>
            </div>
          </li>
          <li><a href="#">Đặt vé</a></li>
          <li><a href="#">Thông tin hành trình
            <div>
              <ul>
                <li><a href="">Hello 1</a></li>
                <li><a href=""> Hello 2</a></li>
                <li><a href="">Hello 3</a></li>
              </ul>
            </div>
          </a></li>
          <li><a href="#">QAirline Club
            <div>
              <ul>
                <li><a href="">Hello 1</a></li>
                <li><a href=""> Hello 2</a></li>
                <li><a href="">Hello 3</a></li>
              </ul>
            </div>
          </a></li>
        </ul>
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
  li {
    list-style-type:none;
  }
  a {color:inherit;}
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
  .navBar > ul {
    display : flex;
    gap : 20px;
    position: relative;
  }

  .navMenu > li {
    position: absolute;
    padding: 10px;
    border-radius: 15px 15px 0px 0px;
    text-align: center;
    background: transparent;
    color: white;
    transition: all 0.3s ease-in-out;
    width: 100px; 
    height: 35px; 
    justify-content: center; /* Căn giữa theo chiều ngang */
            align-items: center; /* Căn giữa theo chiều dọc */
  }

  .navMenu > li:nth-child(1) { left: -300px; top: 0; }
  .navMenu > li:nth-child(2) { left: -150px; top: 0; } /* Thay đổi vị trí ngang */
  .navMenu > li:nth-child(3) { left: 0px; top: 0; }
  .navMenu > li:nth-child(4) { left: 150px; top: 0; }

  .navMenu > li > a {
    font-size : 18px;
    color : #fff;
    font-weight: 500;
    text-decoration: none ;
  }

  .navMenu > li:hover {
    background: white;
    color: darkcyan;
    transition: all 0.3s ease-in-out;
  }

  .navMenu > li:hover > div {
    background: white;
    color: darkcyan;
    transition: all 0.3s ease-in-out;
  }

  .navMenu > li > a {
    color: inherit;
  }
  .navMenu > li > a::before {
    content : '';
    top : 100%;
    position : absolute;
    left : 0;
    width : 100%;
  
  }

  .navMenu > li > div {
    display: none;
    position: absolute;
    left: 0px;
    top: 100%;
    /* right: 0px; */
    padding: 10px;
    border-radius: 0px 10px 10px 10px;
  }

  .navMenu> li:hover >  div {
    display: block;
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

  @media screen and (max-width: 800px) {
    .navBar > ul {
      display: block;
    }
  }
</style>