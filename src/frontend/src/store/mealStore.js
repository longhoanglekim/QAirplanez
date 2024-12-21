import { ref } from "vue";
import { defineStore } from "pinia";
import { ref } from "vue";

export const useMealStore = defineStore('mealStore', () => {
    const mealList = ref([])
    const getMealList = async () => {
        const response = await fetch("http://localhost:8080/api/meal/public/getMealList");
        const data = await response.json();
        mealList.value = data
        return mealList.value
    };
    const getMealById = (id) => {
        return mealList.value.find(meal => meal.id === id)
    }
    return {
        getMealList,
        getMealById
    };
});
