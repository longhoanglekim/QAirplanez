<template>
  <div class="w-full h-[700px] overflow-hidden relative">
    <img :src="require('@/assets/destination/japan.jpg')"
      class="w-full h-full rounded-tl-lg rounded-tr-lg object-cover">
  </div>
  <div class="min-h-screen flex flex-col p-10 m-10 justify-center bg-white gap-20">
    <div>
      <h1 class="leading-tight text-4xl font-bold"> Giới thiệu</h1>
      <p class="mt-4 text-xl">Sở hữu những cảnh quan tuyệt sắc bậc nhất thế giới cùng nền văn hóa ẩn chứa nhiều điều kì
        bí, “xứ
        sở Phù Tang” – Nhật Bản là một trong những quốc gia được mệnh danh là thiên đường du lịch Châu Á. Với mùa hoa
        đào rực rỡ, tháp Tokyo hoành tráng, núi Phú Sĩ đẹp đến nao lòng, nơi đây đã để lại trong lòng du khách nhiều xúc
        cảm khó quên. Ngày nay cách hữu hiệu và nhanh nhất để di du lịch Nhật Bản là sử dụng máy bay. Và đến du lịch
        Nhật Bản thì rất khó để có thể bỏ qua Tokyo, do các sân bay quốc tế nổi tiếng như Narita, Haneda,… đều đặt rất
        gần nơi đây.</p>
    </div>
    <div class="mx-auto max-w-8xl">
      <section class="font-sans text-black">
        <div class="lg:flex lg:items-center">
          <div class="flex-shrink-0 self-stretch xl:w-1/2 mx-auto">
            <div class="aspect-[4/3] w-full lg:max-w-[700px]">
              <article class="w-full h-full">
                <div class="w-full h-full">
                  <img class="w-full h-full object-cover" :src="require('@/assets/destination/tokyo_scene.jpg')" />
                </div>
              </article>
            </div>
          </div>
          <div class="p-6 bg-grey">
            <div class="leading-relaxed">
              <h2 class="leading-tight text-4xl font-bold"> Cảnh quan</h2>
              <p class="mt-4 text-xl">Tokyo là sự kết hợp hoàn hảo giữa những tòa nhà chọc trời hiện đại như tháp Tokyo
                Skytree, khu Shibuya sôi động và không gian thanh bình của đền Senso-ji hay công viên Ueno. Mùa xuân,
                thành phố ngập tràn sắc hồng của hoa anh đào, trong khi mùa thu lại quyến rũ với lá đỏ rực rỡ.</p>
            </div>
          </div>
        </div>
      </section>
    </div>
    <div class="mx-auto max-w-8xl">
      <section class="font-sans text-black">
        <div class="lg:flex lg:items-center">
          <div class="p-6 bg-grey">
            <div class="leading-relaxed">
              <h2 class="leading-tight text-4xl font-bold"> Ẩm thực</h2>
              <p class="mt-4 text-xl">Tokyo là thiên đường ẩm thực với hàng ngàn món ngon. Từ sushi tại Tsukiji, ramen ở
                Ikebukuro, đến món ăn đường phố như takoyaki và taiyaki. Đừng quên thưởng thức wagyu beef hay trải
                nghiệm một bữa ăn kaiseki – tinh hoa ẩm thực truyền thống.</p>
            </div>
          </div>
          <div class="flex-shrink-0 self-stretch xl:w-1/2 mx-auto">
            <div class="aspect-[4/3] w-full lg:max-w-[700px]">
              <article class="w-full h-full">
                <div class="h-full w-full">
                  <img class="h-full w-full object-cover" :src="require('@/assets/destination/tokyo_food.jpg')" />
                </div>
              </article>
            </div>
          </div>
        </div>
      </section>
    </div>
    <div class="mx-auto max-w-8xl">
      <section class="font-sans text-black">
        <div class="lg:flex lg:items-center">
          <div class="flex-shrink-0 self-stretch xl:w-1/2 mx-auto">
            <div class="aspect-[4/3] w-full lg:max-w-[700px]">
              <article class="h-full w-full">
                <div class="h-full w-full">
                  <img class="h-full w-full object-cover" :src="require('@/assets/destination/tokyo_festival.jpg')" />
                </div>
              </article>
            </div>
          </div>
          <div class="p-6 bg-grey">
            <div class="leading-relaxed">
              <h2 class="leading-tight text-4xl font-bold"> Văn hoá</h2>
              <p class="mt-4 text-xl">Tokyo vừa sôi động vừa trang nhã, phản ánh văn hóa Nhật Bản qua từng góc phố. Bạn có thể
                cảm nhận nhịp sống hối hả ở Ginza, nhưng ngay sau đó là sự tĩnh lặng khi bước vào một trà thất truyền
                thống. Những lễ hội như lễ hội pháo hoa mùa hè và các buổi trình diễn nghệ thuật kabuki cũng là điểm
                nhấn độc đáo.</p>
            </div>
          </div>
        </div>
      </section>
    </div>
    <div class="flex justify-center items-center py-12 w-[300px] mx-auto">
      <router-link 
        to="/home" 
        class="w-full text-center bg-blue-600 hover:bg-orange-700 text-white font-bold py-4 px-8 rounded-full text-xl transition duration-300 ease-in-out transform hover:scale-105 shadow-lg"
      >
        Đặt vé ngay
      </router-link>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DestinationDetail',
};

</script>

<style scoped></style>
