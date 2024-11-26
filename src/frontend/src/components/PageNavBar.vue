<template>
     <div class="container">
        <nav class="menu">
            <ul class="main-menu">
                <li class="active"><i class="fa fa-home"></i>Home</li>
                <li class="with-submenu">
                    <i class="fa fa-briefcase"></i>Portfolio <i class="fa fa-caret-down"></i>
                    <ul class="submenu">
                        <li>React</li>
                        <li>JavaScript</li>
                        <li>CSS</li>
                        <li>Animation</li>
                    </ul>
                </li>
                <li><i class="fa fa-user"></i>About</li>
                <li><i class="fa fa-search"></i>Search</li>
            </ul>
        </nav>
        <article>
            <h1>Home</h1>
            <div class="content">
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, et!
                    Veniam, cum. Necessitatibus consectetur, alias facere, cum omnis officia
                    ad architecto dolore rerum voluptatum fuga. Provident, voluptate voluptas? Dolor, blanditiis.
                </p>
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, et!
                    Veniam, cum. Necessitatibus consectetur, alias facere, cum omnis officia
                    ad architecto dolore rerum voluptatum fuga. Provident, voluptate voluptas? Dolor, blanditiis.
                </p>
                <p>
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Assumenda, et!
                    Veniam, cum. Necessitatibus consectetur, alias facere, cum omnis officia
                    ad architecto dolore rerum voluptatum fuga. Provident, voluptate voluptas? Dolor, blanditiis.
                </p>
            </div>
        </article>
    </div>
</template>

<script>
export default {
    name: 'PageNavBar'
}
</script>
<style scoped>
@import url('https://fonts.googleapis.com/css?family=Lexend+Deca&display=swap');

* {
    margin: 0;
    padding: 0;
    font-family: 'Lexend Deca', sans-serif;
    color: #878787;

    --menu-item-size: 50px;
    --green-color: #329680;
    --blue-color: #099c95;
    --dark-green-color: #175b52;
    --white-color: #FFF;
    --gray-color: #EDEDED;
    --container-width: 700px;
    --container-height: 400px;
    --line-offset: calc((100% - var(--container-height))/ 2 + var(--menu-item-size) + 0.6em);
}


.container {
    width: var(--container-width);
    height: var(--container-height);
    margin-left: -350px;
    margin-top: -200px;
    top: 50%;
    left: 50%;
    position: absolute;
    z-index: 1;
}

.main-menu {
    display: flex;
    list-style: none;
    margin: auto 0;
    padding: 0.6em 0 0 0;
}

.main-menu > li {
    box-sizing: border-box;
    height: var(--menu-item-size);
    width: calc(3.5 * var(--menu-item-size));  
    line-height: var(--menu-item-size);
    padding: 0 2em;
    margin: 1px;
    transition: 0.5s linear all;
    background: var(--green-color);
    color: var(--dark-green-color);
    cursor: pointer;
    font-size: 16px;
    user-select: none;
}

.main-menu > li:not(.with-submenu) {
    clip-path: polygon(10% 0%, 0% 100%, 95% 100%, 100% 50%, 95% 0%);
    shape-outside: polygon(10% 0%, 0% 100%, 95% 100%, 100% 50%, 95% 0%);
}

.main-menu > li:nth-child(2) {
    transform: translateX(-5%);
}

.main-menu > li:nth-child(3) {
    transform: translateX(-10%)
}

.main-menu > li:nth-child(4) {
    transform: translateX(-15%)
}

.main-menu i {
    margin-right: 5px;
}

.main-menu > li:hover:not(.active) {
    background: linear-gradient(to right, var(--green-color), var(--blue-color));
    color: var(--white-color);
}

.main-menu > li:active:not(.active),
.main-menu > li:active:not(.with-submenu){
    background: var(--blue-color);
    color: var(--white-color);
}

.main-menu > li:hover i:not(li.active) {
    color: #175c58;
}

.main-menu .active {
    color: var(--white-color);
    background: var(--blue-color);
    cursor: default;
    text-shadow: 1px 1px 1px var(--dark-green-color);
    font-size: 18px;
}

article {
   background: var(--gray-color);
   padding: 1em;
   border-radius: 0 0 5px 5px;
   box-shadow: 5px 5px 5px #CCC;
   position: relative;
   z-index: -1;
}

h1 {
    font-size: 115%;
    margin: 1em 2em;
    padding: 0;
    position: relative;
    color: #777;
}

.content {
    padding: 0 0 0 3em;
    font-size: 16px;
}

.submenu {
    display: none;
    position: absolute;
    z-index: 10;
    list-style: none;
    left: 0;
    margin: 0;
    padding: 0;
    min-width: calc(3.5 * var(--menu-item-size) - 5%);
    box-shadow: 5px 5px 5px #CCC;
}

.with-submenu {
    position: relative;
    display: inline-block;
    clip-path: polygon(10% 0%, 0% 100%, 0% 500%, 95% 500%, 95% 100%, 100% 50%, 95% 0%);
    shape-outside: polygon(10% 0%, 0% 100%, 95% 100%, 100% 50%, 95% 0%);
}

.with-submenu:hover .submenu {
    display: block;
}

.submenu > li {
    background: #dedede;
    border-bottom: 1px solid var(--gray-color); 
    color: #777;
    padding: 1.2em 1em;
    transition: 0.3s all linear;
    display: block;
    line-height: 0%;
}

.submenu > li:hover {
    background: var(--gray-color)
}

.submenu > li:active {
    background: var(--white-color);
}
</style>