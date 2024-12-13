package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.repositories.PassengerRepository;
import com.web.airplane.demo.services.PassengerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/passenger")
public class PassengerController {
    @Autowired
    private PassengerRepository passengerRepository;
    @Autowired
    private PassengerService passengerService;
    @GetMapping("/admin_passenger/allPassengers")
    public ResponseEntity<?> getPassengerList() {
        List<PassengerInfo> passengerInfoList = new ArrayList<>();
        if (passengerRepository.findAll().isEmpty())
            return (ResponseEntity<?>) ResponseEntity.status(HttpStatus.NO_CONTENT);
        for (Passenger passenger : passengerRepository.findAll()) {
            passengerInfoList.add(passengerService.getPassengerInfo(passenger));
        }
        return ResponseEntity.ok(passengerInfoList);
    }
}
