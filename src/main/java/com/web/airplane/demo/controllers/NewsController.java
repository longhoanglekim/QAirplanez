package com.web.airplane.demo.controllers;

import com.web.airplane.demo.repositories.NewsRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import com.web.airplane.demo.services.NewsService;
import com.web.airplane.demo.dtos.News.AddNewsDTO;
import com.web.airplane.demo.models.News;
import java.time.LocalDateTime;
@RestController
@Slf4j
@RequestMapping("/api/news")
public class NewsController {
    @Autowired
    private NewsService newsService;
    @Autowired
    private NewsRepository newsRepository;

    @PostMapping("/create")
    public ResponseEntity<News> createNews(@RequestBody AddNewsDTO news) {
        News newNews = new News();
        newNews.setTitle(news.getTitle());
        newNews.setContent(news.getContent());
        newNews.setCreatedDate(LocalDateTime.now());
        return ResponseEntity.ok(newsService.createNews(newNews));
    }

    @GetMapping("/public/newsList")
    public ResponseEntity<?> getNews() {
        return ResponseEntity.ok(newsRepository.findAll());
    }
}
