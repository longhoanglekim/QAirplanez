package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.News.EditNewsDTO;
import com.web.airplane.demo.dtos.News.NewsResponse;
import com.web.airplane.demo.repositories.NewsRepository;
import com.web.airplane.demo.services.ImageService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import com.web.airplane.demo.services.NewsService;
import com.web.airplane.demo.dtos.News.AddNewsDTO;
import com.web.airplane.demo.models.News;

import java.io.IOException;
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
    @Autowired
    private ImageService imageService;

    @PreAuthorize("hasRole('ADMIN_NEWS')")
    @PostMapping("/create")
    @Transactional
    public ResponseEntity<?> createNews(@RequestParam(name="image", required = false) MultipartFile image, @RequestParam(name="title") String title, @RequestParam(name="content") String content, HttpServletRequest request) throws IOException {
        AddNewsDTO news = new AddNewsDTO();
        news.setTitle(title);
        news.setContent(content);
        if (image == null || image.isEmpty()) {
            log.debug("image for news not found");
//            return ResponseEntity.status(400).body("Image is required");
        } else {
            news.setFile(image);
            log.debug("set file ok");
        }

        return ResponseEntity.ok(newsService.createNews(news, request));
    }
    @PreAuthorize("hasRole('ADMIN_NEWS')")
    @PutMapping("/edit")
    @Transactional
    public ResponseEntity<?> editNews(@RequestBody EditNewsDTO editedNews, @RequestParam(name = "index") Long index) throws IOException {
        News news = newsRepository.findByNewsIndex(index);
        news.setTitle(editedNews.getTitle());
        news.setContent(editedNews.getContent());
        news.setPostingDate(editedNews.getPostingDate());
        if (editedNews.getFile() != null) {
            news.setImage(imageService.storeImage(editedNews.getFile()));
        }
        newsRepository.save(news);
        return ResponseEntity.ok(newsService.getNewsInfo(news));

    }

    @PreAuthorize("hasRole('ADMIN_NEWS')")
    @DeleteMapping("/delete")
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

    @GetMapping("/newsList")
    public ResponseEntity<?> getNews() {
        List<News> newsList = newsRepository.findAll();
        List<NewsResponse> newsResponseList = new ArrayList<>();
        for (News news : newsList) {
            newsResponseList.add(newsService.getNewsInfo(news));
        }
        return ResponseEntity.ok(newsResponseList);
    }

    @GetMapping("/news/{title}")
    public ResponseEntity<?> getNewsByTitle(@PathVariable String title) {
        News news = newsRepository.findByTitle(title);
        if (news == null) {
            return ResponseEntity.status(404).body("News not found");
        }
        return ResponseEntity.ok(newsService.getNewsInfo(news));
    }

    
}
