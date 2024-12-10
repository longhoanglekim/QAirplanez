package com.web.airplane.demo.controllers;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
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

    @PostMapping("/create")
    public ResponseEntity<News> createNews(@RequestBody AddNewsDTO news) {
        News newNews = new News();
        newNews.setTitle(news.getTitle());
        newNews.setContent(news.getContent());
        newNews.setCreatedDate(LocalDateTime.now());
        return ResponseEntity.ok(newsService.createNews(newNews));
    }
}
