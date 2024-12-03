<template>
<div class=" w-full max-w-2xl flex text-left">
    <div v-for="(stage, index) in stages" :key="stage.number" class="flex flex-1">
        <div class="flex flex-col w-full relative">
            <div class="flex justify-center">
              <div class="flex grow " 
                :class="{'border-orange-500': currentStage >= stage.number, 'border-b-2 h-1/2': index > 0}">
              </div>
              <a href="" class="mx-auto flex flex-col items-center justify-center">
                  <div class="border-2 w-8 h-8 rounded-full flex items-center justify-center" :class=" { ' border-none bg-orange-500 text-white font-bold': currentStage > stage.number
      , 'border-orange-500 text-orange-500' : currentStage == stage.number
    }">
                      {{ currentStage > stage.number? '✓':index + 1}}</div>

              </a>
              <div class="flex grow " 
                :class="{'border-orange-500': currentStage > stage.number, 'border-b-2 h-1/2': index < stages.length - 1}">
              </div>
            </div>
            <div class="text-center" :class="{'text-orange-500': currentStage >= index + 1}">{{ stage.label }}</div>
        </div>
        
    </div>
  </div>
  </template>
    
    <script>
    export default {
      props: {
        currentStage: {
          type: Number,
          default: 0
        },
        stages: {
          type: Array,
          default: () =>{
            return [{
                    number: 1,
                    label: 'Thông tin hành khách'
                },
                {
                    number: 2,
                    label: 'Chọn dịch vụ'
                },
                {
                    number: 3,
                    label: 'Hoàn tất'
                }]
          },
          validator(value) {
            // Kiểm tra giá trị của `stages` có đúng định dạng không
            return value.every(stage => stage.number && stage.label);
          },
        },
      }
    }
    </script>