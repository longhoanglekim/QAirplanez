package com.web.airplane.demo.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.web.airplane.demo.models.News;
import com.web.airplane.demo.repositories.NewsRepository;

@Service
public class NewsService {
     @Autowired
    private NewsRepository newsRepository;
    
    public News createNews(News news) {
        news.setCreatedDate(LocalDateTime.now());
        return newsRepository.save(news);
    }

}
