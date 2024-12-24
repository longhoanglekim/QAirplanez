package com.web.airplane.demo.services;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.web.airplane.demo.dtos.News.AddNewsDTO;
import com.web.airplane.demo.dtos.News.NewsResponse;
import com.web.airplane.demo.models.Image;
import com.web.airplane.demo.models.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.web.airplane.demo.models.News;
import com.web.airplane.demo.repositories.ImageRepository;
import com.web.airplane.demo.repositories.NewsRepository;

@Slf4j
@Service
public class NewsService {
     @Autowired
    private NewsRepository newsRepository;
     @Autowired
     private UserService userService;
     @Autowired
     private ImageService imageService;
    @Autowired
    private ImageRepository imageRepository;
    
    @Transactional
    public NewsResponse createNews(AddNewsDTO newsInfo, HttpServletRequest request) throws IOException {
        News news = new News();
        news.setNewsIndex(newsRepository.findMaxIndex() + 1);
        news.setTitle(newsInfo.getTitle());
        news.setContent(newsInfo.getContent());
        news.setPostingDate(LocalDateTime.now());
        User user = userService.getCurrentUser(request);
        news.setAuthor(user);

        Image newImage = new Image();
        newImage = imageService.storeImage(newsInfo.getFile());
        imageRepository.save(newImage);
        news.setImage(newImage);
        log.debug("newsGetfile"+ newsInfo.getFile());
        newsRepository.save(news);



        return getNewsInfo(news);
    }



    public NewsResponse getNewsInfo(News news) {
        NewsResponse newsResponse = new NewsResponse();
        newsResponse.setIndex(news.getNewsIndex());
        newsResponse.setTitle(news.getTitle());
        newsResponse.setPostingDate(news.getPostingDate());
        newsResponse.setEditDate(news.getEditDate());
        newsResponse.setContent(news.getContent());
        newsResponse.setAuthor(news.getAuthor().getFirstname() + " " + news.getAuthor().getLastname());
        if (news.getImage() != null) newsResponse.setUrlImage(imageService.getImage(news.getImage()));
        
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
