package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.News.EditNewsDTO;
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
    @PutMapping("/admin_news/edit")
    @Transactional
    public ResponseEntity<?> editNews(@RequestBody EditNewsDTO editedNews, @RequestParam(name = "index") Long index) {
        News news = newsRepository.findByNewsIndex(index);
        news.setTitle(editedNews.getTitle());
        news.setContent(editedNews.getContent());
        news.setPostingDate(editedNews.getPostingDate());
        newsRepository.save(news);
        return ResponseEntity.ok(newsService.getNewsInfo(news));

    }

    @DeleteMapping("/admin_news/delete")
    @Transactional
    public ResponseEntity<?> deleteNews(@RequestParam(name = "index") Long index) {
        log.debug("Delete" + index);
        newsRepository.delete(newsRepository.findByNewsIndex(index));
        List<News> greaterList = newsService.getNewsWithIndexGreaterThan(index);
        for (News news : greaterList) {
            news.setNewsIndex(news.getNewsIndex() - 1);
            newsRepository.save(news);
        }
        return ResponseEntity.ok("Đã xóa News với index = " + index);
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
