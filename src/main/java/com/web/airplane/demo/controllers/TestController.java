package com.web.airplane.demo.controllers;

import com.web.airplane.demo.exceptions.SeatUnavailableException;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.services.FlightService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.TimeZone;

@RestController
@Slf4j
@RequestMapping("/test")
public class TestController {
    @Autowired
    private FlightService flightService;
    @Autowired
    private FlightRepository flightRepository;
    @GetMapping("/string")
    public ResponseEntity<?> getMessage() throws SeatUnavailableException {
        TimeZone tz = TimeZone.getDefault();
        log.debug(tz.getID());
        return ResponseEntity.ok().body(tz.getID());

    }
    
}
