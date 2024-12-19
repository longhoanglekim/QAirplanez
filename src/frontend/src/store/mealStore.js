import { defineStore } from "pinia";

export const useMealStore = defineStore('mealStore', () => {
    const getMealList = async () => {
        const response = await fetch("http://localhost:8080/api/meal/public/getMealList");
        const data = await response.json();
        return data;
    };

    return {
        getMealList
    };
});
