<template>
<form @submit.prevent="handleSubmit" class="max-w-4xl grid md:grid-cols-2 gap-5 p-5" novalidate>
    <div class="relative z-0 w-full mb-5">

        <input type="text" v-model="formData.firstName" name="firstName" placeholder=" " :class="[
                    'relative text-black capitalize pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.firstName ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.firstName}
                  ]" @blur="validFirstName" />
        <EthernetPort class="absolute right-0 top-5 text-gray-500" />

        <label class="absolute duration-300 top-3 -z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.firstName}">
            Họ<span class="text-red-500">*</span>:
        </label>
        <span v-if="errors.firstName" class="text-sm text-red-600">
            {{ errorsData.firstName }}
        </span>

    </div>

    <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="formData.lastName" name="lastName" placeholder=" " :class="[
                    'relative text-black  pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.lastName ? 'border-red-500' : 'border-gray-200' , {'text-red-600': errors.firstName}
                  ]" @blur="validLastName" />
        <EthernetPort class="absolute right-0 top-5 text-gray-500" />
        <label class="pointer-events-none absolute duration-300 top-3 z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.lastName}">
            Tên đệm và tên<span class="text-red-500">*</span>:
        </label>
        <span v-if="errors.lastName" class="text-sm text-red-600">
            {{ errorsData.lastName }}
        </span>
    </div>
    <div class="relative z-0 w-full mb-5">
        <select name="gender" v-model="formData.gender" class="text-black pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black">
            <option value="male">Nam</option>
            <option value="female">Nữ</option>
        </select>
        <label class="pointer-events-none absolute duration-300 top-3 z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.gender}">
            Giới tính<span class="text-red-500">*</span>
        </label>
    </div>
    <div class="relative z-0 w-full mb-5">
        <input type="date" v-model="formData.birthDate" name="birthDate" placeholder=""
                @blur="validBirthDate"
                :class="[
                    'text-black pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.birthDate ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.birthDate}
                  ]"/>
        <label class="pointer-events-none absolute duration-300 top-3 z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.birthDate}">
            Ngày sinh<span class="text-red-500">*</span>
        </label>
        <span v-if="errors.birthDate" class="text-sm text-red-600">
            {{ errorsData.birthDate }}
        </span>
    </div>
    
    <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="formData.phone" name="phone" placeholder=" " :class="[
                    'relative text-black pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.phone ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.lastName}
                  ]" @blur="validPhone" />
        <Phone class="absolute right-0 top-5 text-gray-500" />
        <label class="pointer-events-none absolute duration-300 top-3 z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.phone}">
            Số điện thoại:<span class="text-red-500">*</span>
        </label>
        <span v-if="errors.phone" class="text-sm text-red-600">
            {{ errorsData.phone }}
        </span>
    </div>

    <div class="relative z-0 w-full mb-5">
        <input type="text" v-model="formData.cccd" name="cccd" placeholder=" " :class="[
                    'text-black  pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.cccd ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.cccd}
                  ]" @blur="validCccd" />
        <IdCard class="absolute right-0 top-5 text-gray-500" />
        <label class="pointer-events-none absolute duration-300 top-3 z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.cccd}">
            CCCD/CMND:<span class="text-red-500">*</span>
        </label>
        <span v-if="errors.cccd" class="text-sm text-red-600">
            {{ errorsData.cccd }}
        </span>
    </div>

    <div class="relative z-0 w-full mb-5">
        <input type="email" v-model="formData.email" name="email" placeholder=" " :class="[
                    'text-black pt-3 pb-2 block w-full px-0 mt-0 bg-transparent border-0 border-b-2 appearance-none focus:outline-none focus:ring-0 focus:border-black',
                    errors.email ? 'border-red-500' : 'border-gray-200', {'text-red-600': errors.email}
                  ]" @blur="validEmail" />
        <Mail class="absolute right-0 top-5 text-gray-500" />
        <label class="pointer-events-none absolute duration-300 top-3 z-10 origin-0 text-gray-500 left-0" :class="{'text-red-600': errors.email}">
            Email<span class="text-red-500">*</span>
        </label>
        <span v-if="errors.email" class="text-sm text-red-600">
            {{ errorsData.email }}
        </span>
    </div>
    
</form>
</template>             
    
<script setup>
import {
    ref,
    reactive,
    defineEmits,
    defineExpose
} from 'vue'
const formData = reactive({
    firstName: '',
    lastName: '',
    phone: '',
    cccd: '',
    email: '',
    birthDate: '',
    gender: ''
})

const errors = reactive({
    firstName: false,
    lastName: false,
    phone: false,
    cccd: false,
    email: false,
    birthDate: false,
    gender: false
})

const errorsData = reactive({
    firstName: '',
    lastName: '',
    phone: '',
    cccd: '',
    email: '',
    birthDate: '',
    gender: ''
})

const validFirstName = () => {
    errors.firstName = false
    if (formData.firstName == null || formData.firstName === '') {
        errorsData.firstName = 'Vui lòng điền họ'
        errors.firstName = true
    } else if (!/^[A-Za-zÀ-ÿ\s]+$/.test(formData.firstName)) {
        errorsData.firstName = 'Vui lòng điền họ hợp lệ'
        errors.firstName = true
    }
}
const validLastName = () => {
    errors.lastName = false
    if (formData.lastName == null || formData.lastName === '') {
        errorsData.lastName = 'Vui lòng điền tên'
        errors.lastName = true
    } else if (!/^[A-Za-zÀ-ÿ\s]+$/.test(formData.lastName)) {
        errorsData.lastName = 'Vui lòng điền tên hợp lệ'
        errors.lastName = true
    }
}

const validBirthDate = () => {
    errors.birthDate = false;

    if (!formData.birthDate || formData.birthDate.trim() === '') {
        errorsData.birthDate = 'Vui lòng điền ngày sinh';
        errors.birthDate = true;
    } else {
        const today = new Date();
        const cutoffDate = new Date();
        cutoffDate.setFullYear(today.getFullYear() - 18);

        const userBirthDate = new Date(formData.birthDate);

        if (isNaN(userBirthDate.getTime())) {
            errorsData.birthDate = 'Ngày sinh không hợp lệ';
            errors.birthDate = true;
        } else if(userBirthDate > today) {
            errorsData.birthDate = 'Vui lòng điền đúng ngày sinh';
            errors.birthDate = true;
        } else if (userBirthDate > cutoffDate) {
            errorsData.birthDate = 'Bạn phải đủ 18 tuổi';
            errors.birthDate = true;
        } else {
            errorsData.birthDate = '';  
            errors.birthDate = false;
        }
    }
};
const validCccd = () => {
    errors.cccd = false
    if (formData.cccd == null || formData.cccd == '') {
        errorsData.cccd = 'Vui lòng điền số CCCD/CMND'
        errors.cccd = true
    } else if (formData.cccd.length !== 9 && formData.cccd.length !== 12) {
        errorsData.cccd = "Căn cước công dân hoặc chứng minh nhân dân phải có 9 hoặc 12 ký tự.";
        errors.cccd = true
    } else if (!/^[0-9]*/.test(formData.cccd)) {
        errorsData.cccd = 'Vui lòng điền số CCCD/CMND hợp lệ'
        errors.cccd = true
    }
}
const validEmail = () => {
    errors.email = false;
    if (formData.email == null || formData.email === '') {
        errorsData.email = 'Vui lòng điền email'; // Thông báo lỗi nếu không có email
        errors.email = true;
    } else {
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(formData.email)) {
            errorsData.email = 'Vui lòng điền email hợp lệ'; // Thông báo lỗi nếu email không hợp lệ
            errors.email = true;
        }
    }
}

const validPhone = () => {
    errors.phone = false
    if (formData.phone == null || formData.phone == '') {
        errorsData.phone = 'Vui lòng điền số điện thoại'
        errors.phone = true
    } else if (formData.phone.indexOf(0) != '0' || formData.phone.length != 10) {
        errorsData.phone = 'Vui lòng điền số điện thoại hợp lệ'
        errors.phone = true
    }
}

const submitted = ref(false)
const emit = defineEmits(['submit'])

const validateForm = () => {
    validCccd()
    validEmail()
    validFirstName()
    validLastName()
    validPhone()
    validBirthDate()
    return !(errors.firstName || errors.lastName || errors.phone || errors.email || errors.birthDate)
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

const getPassengerData = () => {
    return formData
}

defineExpose({
  getPassengerData,
  validateForm
})
</script>
<script>
    import {
        EthernetPort
    } from "lucide-vue-next";
    import {
        Phone
    } from "lucide-vue-next";
    import {
        IdCard
    } from 'lucide-vue-next';
    import {
        Mail
    } from 'lucide-vue-next';
    export default {
        components: {
            EthernetPort,
            Phone,
            IdCard,
            Mail
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
