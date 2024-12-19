package com.web.airplane.demo.repositories;


import org.springframework.data.jpa.repository.JpaRepository;

import com.web.airplane.demo.models.Meal;

public interface MealReposity extends JpaRepository<Meal, Long> {
}

