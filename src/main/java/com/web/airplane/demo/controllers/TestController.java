package com.web.airplane.demo.controllers;

import com.web.airplane.demo.exceptions.SeatUnavailableException;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.services.FlightService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;

import com.web.airplane.demo.models.News;
import com.web.airplane.demo.services.NewsService;
import com.web.airplane.demo.dtos.News.AddNewsDTO;
import java.time.LocalDateTime;

@RestController
@Slf4j
@RequestMapping("/test")
public class TestController {
    @Autowired
    private FlightService flightService;
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private NewsService newsService;
    @GetMapping("/string")
    public String getMessage() throws SeatUnavailableException {
        Flight departFlight = flightRepository.findByFlightNumber("VN123");
        if (departFlight != null) {
            return "Có";
        }
        return "không";
    }


    @GetMapping("/admin")
    public String getAdmin() {
        return "Admin";
    }


    @GetMapping("/admin_flight")
    public String getAdminFlight() {
        return "Admin Flight";
    }
    
    @PostMapping("/createNews")
    public ResponseEntity<News> createNews(@RequestBody AddNewsDTO news) {
        News newNews = new News();
        newNews.setTitle(news.getTitle());
        newNews.setContent(news.getContent());
        newNews.setPostingDate(LocalDateTime.now());
        return ResponseEntity.ok((newNews));
    }
}
