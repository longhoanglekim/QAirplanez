package com.web.airplane.demo.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.web.airplane.demo.services.MealService;
import com.web.airplane.demo.models.Meal;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/meal")
@Slf4j
public class MealController {
    @Autowired
    private MealService mealService;

    @GetMapping("/public/getMealList")
    public List<Meal> getAllMeals() {
        return mealService.getAllMeals();
    }

    @GetMapping("/public/getMealById/{id}")
    public Meal getMealById(@PathVariable Long id) {
        return mealService.getMealById(id);
    }

    @PostMapping("/admin_meal/createMeal")
    @Transactional
    public Meal createMeal(@RequestBody Meal meal) {
        return mealService.createMeal(meal);
    }

    @DeleteMapping("/admin_meal/deleteMeal/{id}")
    @Transactional
    public String deleteMeal(@PathVariable Long id) {
        return mealService.deleteMeal(id);
    }
}
