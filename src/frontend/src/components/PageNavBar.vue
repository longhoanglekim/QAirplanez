<template>
    <div class="header">
      <a class="logo"><p>
        <img src="@/assets/home/logo.jpg" alt="Background Image">
      </p></a>
      <nav class="navBar">
        <ul class="navMenu">
          <li class="navItem">
            <a href="#">Khám phá</a>
            <div>
              <ul>
                <li><a href="">Hello 1</a></li>
                <li><a href=""> Hello 2</a></li>
                <li><a href="">Hello 3</a></li>
              </ul>
            </div>
          </li>
          <li class="navItem"><a href="#">Đặt vé</a></li>
          <li class="navItem"><a href="#">Thông tin hành trình
            <div>
              <ul>
                <li><a href="">Hello 1</a></li>
                <li><a href=""> Hello 2</a></li>
                <li><a href="">Hello 3</a></li>
              </ul>
            </div>
          </a></li>
          <li class="navItem"><a href="#">QAirline Club
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
  * {
    color: white;
    box-sizing: content-box;
  }

  li {
    list-style-type:none;
  }
  a {color:inherit;}
  .header {
    background-color: #0b1224;
    width: 100%;
    display : flex;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
    gap : 20px;
    margin-bottom: 20px;
    padding-bottom: 5px;
    padding-top : 5px;
  }
  .navBar > ul {
    display : flex;
    gap : 20px;
    position: relative;
  }

  .navMenu {
    position: relative;
  }

  .navItem {
    position: absolute;
    padding-bottom: 20px;
    border-radius: 15px 15px 0px 0px;
    text-align: center;
    background: transparent;
    transition: all 0.3s ease-in-out;
    width: 150px; 
    justify-content: center; 
    align-items: center;
    top: -10px;
  }

  .navItem:nth-child(1) { left: -400px; }
  .navItem:nth-child(2) { left: -200px; } /* Thay đổi vị trí ngang */
  .navItem:nth-child(3) { left: 0px; }
  .navItem:nth-child(4) { left: 200px; }

  .navItem > a {
    font-size : 18px;
    font-weight: 500;
    text-decoration: none ;
  }

  .navItem:hover {
    background: #0b1224;
    color: darkcyan;
    transition: all 0.3s ease-in-out;
  }

  .navItem:hover > div {
    background: #0b1224;
    color: darkcyan;
    transition: all 0.3s ease-in-out;
  }

  .navItem a {
    color: inherit;
  }
  .navItem a::before {
    content : '';
    top : 100%;
    position : absolute;
    left : 0;
    width : 100%;
  
  }

  .navItem > div {
    display: none;
    position: absolute;
    left: 0px;
    top: 100%;
    /* right: 0px; */
    padding: 10px;
    border-radius: 0px 10px 10px 10px;
  }

  .navItem:hover >  div {
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