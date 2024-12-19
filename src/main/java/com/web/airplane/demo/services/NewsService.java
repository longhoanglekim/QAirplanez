package com.web.airplane.demo.services;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.web.airplane.demo.dtos.News.AddNewsDTO;
import com.web.airplane.demo.dtos.News.NewsResponse;
import com.web.airplane.demo.models.Image;
import com.web.airplane.demo.models.User;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.web.airplane.demo.models.News;
import com.web.airplane.demo.repositories.NewsRepository;

@Service
public class NewsService {
     @Autowired
    private NewsRepository newsRepository;
     @Autowired
     private UserService userService;
    
    public NewsResponse createNews(AddNewsDTO newsInfo, HttpServletRequest request) {
        News news = new News();
        news.setNewsIndex(newsRepository.findMaxIndex() + 1);
        news.setTitle(newsInfo.getTitle());
        news.setContent(newsInfo.getContent());
        news.setPostingDate(LocalDateTime.now());
        User user = userService.getCurrentUser(request);
        news.setAuthor(user);
        newsRepository.save(news);
        return getNewsInfo(news);
    }



    public NewsResponse getNewsInfo(News news) {
        NewsResponse newsResponse = new NewsResponse();
        newsResponse.setIndex(news.getNewsIndex());
        newsResponse.setTitle(news.getTitle());
        newsResponse.setPostingDate(news.getPostingDate());
        newsResponse.setEditDate(news.getEditDate());
        newsResponse.setImageList(new ArrayList<>());


        newsResponse.setContent(news.getContent());
        newsResponse.setAuthor(news.getAuthor().getFirstname() + " " + news.getAuthor().getLastname());
        return newsResponse;
    }

    public List<News> getNewsWithIndexGreaterThan(long index) {
        List<News> newsList = newsRepository.findAll();
        newsList = newsList.stream()
                .filter(news -> news.getNewsIndex() > index)
                .collect(Collectors.toList());
        return newsList;
    }
}
