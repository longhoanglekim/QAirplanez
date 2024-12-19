package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.News.NewsResponse;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.NewsRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import com.web.airplane.demo.services.NewsService;
import com.web.airplane.demo.dtos.News.AddNewsDTO;
import com.web.airplane.demo.models.News;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/api/news")
public class NewsController {
    @Autowired
    private NewsService newsService;
    @Autowired
    private NewsRepository newsRepository;

    @PostMapping("/admin_news/create")
    @Transactional
    public ResponseEntity<?> createNews(@RequestBody AddNewsDTO news, HttpServletRequest request) {

        return ResponseEntity.ok(newsService.createNews(news, request));
    }

    @GetMapping("/public/newsList")
    public ResponseEntity<?> getNews() {
        List<News> newsList = newsRepository.findAll();
        List<NewsResponse> newsResponseList = new ArrayList<>();
        for (News news : newsList) {
            newsResponseList.add(newsService.getNewsInfo(news));
        }
        return ResponseEntity.ok(newsResponseList);
    }
}
