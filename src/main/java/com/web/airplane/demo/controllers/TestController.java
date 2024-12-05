package com.web.airplane.demo.controllers;

import com.web.airplane.demo.exceptions.SeatUnavailableException;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.services.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test")
public class TestController {
    @Autowired
    private FlightService flightService;
    @Autowired
    private FlightRepository flightRepository;
    @GetMapping("/string")
    public ResponseEntity<?> getMessage() throws SeatUnavailableException {
        String string = "abc";
        return ResponseEntity.ok().body(string);

    }
    
}
