package com.web.airplane.demo.repositories;


import com.web.airplane.demo.models.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Long> {
}
