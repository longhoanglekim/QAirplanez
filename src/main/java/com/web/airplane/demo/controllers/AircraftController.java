package com.web.airplane.demo.controllers;


import com.web.airplane.demo.dtos.AircraftInfo;

import com.web.airplane.demo.models.Aircraft;

import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.services.AircraftService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/aircraft")
public class AircraftController {

    private final AircraftRepository aircraftRepository;
    @Autowired
    private AircraftService aircraftService;

    public AircraftController(AircraftRepository aircraftRepository) {
        this.aircraftRepository = aircraftRepository;
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("/admin/addAircraft")
    public ResponseEntity<?> addAircraft(AircraftInfo aircraftInfo) {
        try {

                Aircraft aircraft = new Aircraft();
                aircraft.setStatus(aircraft.getStatus());
                aircraft.setModel(aircraftInfo.getModel());
                aircraft.setManufacturer(aircraft.getManufacturer());
                aircraft.setFlights(null);
                aircraft.setNumberOfSeats(aircraftInfo.getNumberOfSeats());
                aircraftRepository.save(aircraft);

            return ResponseEntity.ok(aircraftInfo);
        } catch (Exception e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping("/admin/aircraftList")
    public List<AircraftInfo> getAircraftList() {
        List<Aircraft> aircraftList = aircraftRepository.findAll();
        List<AircraftInfo> aircraftInfoList = new ArrayList<>();
        for (Aircraft aircraft : aircraftList) {
           AircraftInfo newAircraftInfo = aircraftService.getAircraftInfo(aircraft);
            aircraftInfoList.add(newAircraftInfo);
        }
        return aircraftInfoList;
    }

    //Chua test
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PutMapping("/admin/editAircraft")
    public ResponseEntity<?> editAircraft(@RequestBody AircraftInfo aircraftInfo) {
        try {
            // find tau bay
            Aircraft aircraft = aircraftRepository.findByManufacturerAndModel(
                aircraftInfo.getManufacturer(), 
                aircraftInfo.getModel()
            );
            
            if (aircraft == null) {
                return ResponseEntity.notFound().build();
            }

            // thay doi thong tin
            aircraft.setStatus(aircraftInfo.getStatus());
            aircraft.setModel(aircraftInfo.getModel());
            aircraft.setManufacturer(aircraftInfo.getManufacturer());
            aircraft.setNumberOfSeats(aircraftInfo.getNumberOfSeats());

            // luu lai
            aircraftRepository.save(aircraft);

            return ResponseEntity.ok(aircraftService.getAircraftInfo(aircraft));
        } catch (Exception e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
