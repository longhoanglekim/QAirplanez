<template>
<div class="container justify-center bg-orange-50">
    <header class="flex items-center justify-center mb-10 pt-20">
        <BookingProgressBar :current-stage="2" />
    </header>
    <main class="space-y-4">
        <div class="custom w-full max-w-4xl place-self-center rounded-lg bg-white m-8" v-for="i in adults" :key="i">
            <h1 class="text-left p-5 font-bold">Người lớn {{ i }}</h1>
            <adult-passenger-form ref="adultForms"></adult-passenger-form>
        </div>

        <div class="custom w-full max-w-4xl place-self-center rounded-lg bg-white m-8" v-for="i in children" :key="i">
            <h1 class="text-left p-5 font-bold">Trẻ em {{ i }}</h1>
            <child-passenger-form ref="childForms"></child-passenger-form>
        </div>

        <div class="my-20">
            <button @click="sendPassengerInformation" class="p-5 rounded-xl bg-orange-500 hover:scale-105 custom">
                Xác nhận thông tin
            </button>
        </div>
        <ErrorModal v-model="error"/>
    </main>
    <footer class="my-10"></footer>
</div>
</template>

  
  
<script setup>
import AdultPassengerForm from '@/components/composable/form/AdultPassengerForm.vue';
import ChildPassengerForm from '@/components/composable/form/ChildPassengerForm.vue';
import ErrorModal from '@/components/composable/ErrorModal.vue';
import { searchFlightStore } from '@/store/searchFlight';
import {
    ref
} from 'vue'
import { useRouter } from 'vue-router';

const route = useRouter()

const storeForm = searchFlightStore()
// Reactive variables
const adults = ref(storeForm.getOldForm().adults)
const children = ref(storeForm.getOldForm().children)
const adultForms = ref([])
const childForms = ref([])

const error = ref(false)

const sendPassengerInformation = async () => {
    // Validate tất cả các form
    const adultFormsValid = adultForms.value.every(form => form.validateForm())
    const childFormsValid = childForms.value.every(form => form.validateForm())

    // Nếu không hợp lệ, dừng lại và thông báo
    if (!adultFormsValid || !childFormsValid) {
        console.error('Vui lòng kiểm tra lại thông tin')
        error.value = true
        return
    }

    // Thu thập thông tin từ các form người lớn
    const adultPassengers = adultForms.value.map(form => form.getPassengerData())

    // Thu thập thông tin từ các form trẻ em
    const childPassengers = childForms.value.map(form => form.getPassengerData())

    // Gộp dữ liệu
    const passengerData = {
        adults: adultPassengers,
        children: childPassengers
    }
    console.log(passengerData)
    route.push('/booking/information/2')
    // Gửi dữ liệu lên server
    //await submitPassengerData(passengerData)
}

// Gửi dữ liệu lên server
// const submitPassengerData = async (data) => {
//     console.log(data)
    // try {
    //     const response = await axios.post('/api/passengers', data)

    //     // Xử lý kết quả từ server
    //     if (response.data.success) {
    //         toast.success('Đã gửi thông tin thành công')
    //         // Chuyển sang bước tiếp theo hoặc làm gì đó khác
    //         // this.$router.push('/next-step')
    //     } else {
    //         toast.error('Gửi thông tin thất bại')
    //     }
    // } catch (error) {
    //     console.error('Lỗi khi gửi thông tin:', error)
    //     toast.error('Đã có lỗi xảy ra')
    // }
//}
</script>

<style scoped>
.custom {
    box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.3), 0px 4px 6px rgba(0, 0, 0, 0.3);
}
</style>
