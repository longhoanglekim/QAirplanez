package com.web.airplane.demo.services;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import java.util.Optional;
import com.web.airplane.demo.models.Meal;
import com.web.airplane.demo.repositories.MealReposity;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MealService {
    @Autowired
    private MealReposity mealReposity;

    public List<Meal> getAllMeals() {
        return mealReposity.findAll();
    }

    public Meal getMealById(Long id) {
        Optional<Meal> meal = mealReposity.findById(id);
        return meal.orElseThrow(() -> new RuntimeException("khong tim thay meal voi id: " + id));
    }

    public Meal createMeal(Meal meal) {
        return mealReposity.save(meal);
    }

    public boolean deleteMeal(Long id) {
        mealReposity.deleteById(id);
        return true;
    }
}

