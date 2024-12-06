<template>
  <div class="max-w-md mx-auto ">
    <div>
      <h1 class="custom text-white text-2xl text-center font-bold rounded-lg p-4 w-5/6 mx-auto translate-y-1/2">
        <slot name="header">Lorem Ipsum Dolor</slot>
      </h1>
    </div>
    <div class="rounded-xl bg-slate-100 p-5 w-full pt-10">
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
  name: "CardComponent",
};
</script>

<style scoped>
.custom {
  background-image: linear-gradient(147deg, #FFE53B 0%, #fd3838 74%)
}
</style>
