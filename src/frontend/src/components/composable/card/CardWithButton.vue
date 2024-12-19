"<template>
    <div class="max-w-4xl mx-auto w-full">
      <div>
        <h1 class="custom cursor-pointer text-white text-2xl text-center font-bold rounded-lg p-4 w-5/6 mx-auto translate-y-1/2"
        @click="handleClick">
          <slot name="header" >Lorem Ipsum Dolor</slot>
        </h1>
      </div>
      <div class="rounded-xl bg-white m-3 p-2 w-full pt-10 border-4 border-red-400">
        <h2 class="text-xl border-b-2 border-red-400">
          <slot name="slogan">26 December 2019</slot>
        </h2>
        <div class="mt-5">
          <slot name="content">Lorem ipsum dolor sit amet consectetur, adipisicing elit. Recusandae voluptate repellendus magni illo ea animi?</slot>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  export default {
  methods: {
    handleClick() {
        this.$emit('beClicked')
    }
  },
    name: "CardWithButton",
    
  };
  </script>
  
  <style scoped>
  .custom {
    background-color: #eaa347;
  }
  </style>
  "