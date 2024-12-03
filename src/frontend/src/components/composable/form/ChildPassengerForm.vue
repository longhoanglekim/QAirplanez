<template>
<form @submit.prevent="handleSubmit" class=" grid md:grid-cols-2 gap-5 p-5" novalidate>
    <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="formData.firstName" name="firstName" placeholder=" " :class="[
                    'relative text-black capitalize pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.firstName ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.firstName }, {'text-red-600' : formData.firstName}
                  ]" @blur="validFirstName" />
      <EthernetPort class="absolute right-0 top-5 text-gray-500"/>
        <label class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.firstName}">
            Họ<span class="text-red-500">*</span>:
        </label>
        <span v-if="errors.firstName" class="text-sm text-red-600">
            {{ errorsData.firstName }}
        </span>
    </div>

    <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="formData.lastName" name="lastName" placeholder=" " :class="[
                    'relative text-black pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.lastName ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.lastName}, {'text-red-600' : formData.lastName}
                  ]" @blur="validLastName" />
      <EthernetPort class="absolute right-0 top-5 text-gray-500"/>
        <label class="absolute duration-300 top-3 -z-1 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.lastName}">
            Tên đệm và tên<span class="text-red-500">*</span>:
        </label>
        <span v-if="errors.lastName" class="text-sm text-red-600">
            {{ errorsData.lastName }}
        </span>
    </div>
</form>
</template>

<script setup>
import {
    ref,
    reactive,
    defineEmits
} from 'vue'

const formData = reactive({
    firstName: '',
    lastName: '',
})

const errors = reactive({
    firstName: false,
    lastName: false,
})

const errorsData = reactive({
    firstName: '',
    lastName: '',
})

const validFirstName = () => {
    errors.firstName = false
    if (formData.firstName == null || formData.firstName == '') {
        errorsData.firstName = 'Vui lòng điền họ'
        errors.firstName = true
    } else if (!/^[A-Za-z]+$/.test(formData.firstName)) {
        errorsData.firstName = 'Vui lòng điền họ hợp lệ'
        errors.firstName = true
    }
}
const validLastName = () => {
    errors.lastName = false
    if (formData.lastName == null || formData.lastName == '') {
        errorsData.lastName = 'Vui lòng điền tên'
        errors.lastName = true
    } else if (!/^[A-Za-z]+$/.test(errorsData.lastName)) {
        errorsData.lastName = 'Vui lòng điền tên hợp lệ'
        errors.lastName = true
    }
}

const submitted = ref(false)
const emit = defineEmits(['submit'])

const validateForm = () => {
    errors.firstName = !formData.firstName.trim()
    errors.name = !formData.fullName.trim()
    errors.phone = !formData.phone.trim()
    errors.email = !formData.email.trim() ||
        !/\S+@\S+\.\S+/.test(formData.email)

    return !(errors.firstName || errors.name || errors.phone || errors.email)
}

const handleSubmit = () => {
    submitted.value = true
    if (validateForm()) {
        console.log(errors)
        emit('submit', {
            ...formData
        })
        submitted.value = false // Reset after successful submission
    }
}
</script>
<script>
import {EthernetPort} from "lucide-vue-next";
export default {
  components: {
    EthernetPort
  }
}
</script>
    
<style scoped>

.origin-0 {
    transform-origin: 0%;
}

input:focus~label,
input:not(:placeholder-shown)~label,
textarea:focus~label,
textarea:not(:placeholder-shown)~label,
select:focus~label,
select:not([value='']):valid~label {
    /* @apply transform; scale-75; -translate-y-6; */
    --tw-translate-x: 0;
    --tw-translate-y: 0;
    --tw-rotate: 0;
    --tw-skew-x: 0;
    --tw-skew-y: 0;
    transform: translateX(var(--tw-translate-x)) translateY(var(--tw-translate-y)) rotate(var(--tw-rotate)) skewX(var(--tw-skew-x)) skewY(var(--tw-skew-y)) scaleX(var(--tw-scale-x)) scaleY(var(--tw-scale-y));
    --tw-scale-x: 0.75;
    --tw-scale-y: 0.75;
    --tw-translate-y: -1.5rem;
}

input:focus~label,
select:focus~label {
    /* @apply text-black; left-0; */
    --tw-text-opacity: 1;
    color: rgba(0, 0, 0, var(--tw-text-opacity));
    left: 0px;
}
</style>
