package com.web.airplane.demo.controllers;


import com.web.airplane.demo.dtos.AircraftInfo;

import com.web.airplane.demo.models.Aircraft;

import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.services.AircraftService;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

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


    @PreAuthorize("hasRole('ADMIN_AIRCRAFT')")
    @PostMapping("/addAircraft")
    public ResponseEntity<?> addAircraft(@RequestBody AircraftInfo aircraftInfo) {
        try {
            log.debug(aircraftInfo.toString());
            String serialNumber = aircraftService.createAircraft(aircraftInfo);
            return ResponseEntity.ok(aircraftService
                .getAircraftInfo(aircraftRepository.findBySerialNumber(serialNumber)));
        } catch (Exception e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PreAuthorize("hasRole('ADMIN_AIRCRAFT')")
    @GetMapping("/aircraftList")
    public List<AircraftInfo> getAircraftList() {
        List<Aircraft> aircraftList = aircraftRepository.findAll();
        List<AircraftInfo> aircraftInfoList = new ArrayList<>();
        for (Aircraft aircraft : aircraftList) {
           AircraftInfo newAircraftInfo = aircraftService.getAircraftInfo(aircraft);
            aircraftInfoList.add(newAircraftInfo);
        }
        return aircraftInfoList;
    }

    @PreAuthorize("hasRole('ADMIN_AIRCRAFT')")
    @PutMapping("/editAircraft")
    public ResponseEntity<?> editAircraft(@RequestBody AircraftInfo aircraftInfo) {
        try {
            // find tau bay
            Aircraft aircraft = aircraftRepository.findBySerialNumber(aircraftInfo.getSerialNumber());
            
            if (aircraft == null) {
                return ResponseEntity.notFound().build();
            }
            log.debug("aircraft: " + aircraft.getSerialNumber());
            // thay doi thong tin
            aircraft.setStatus(aircraftInfo.getStatus());
            aircraft.setModel(aircraftInfo.getModel());
            aircraft.setManufacturer(aircraftInfo.getManufacturer());
            aircraft.setNumberOfSeats(aircraftInfo.getNumberOfSeats());

            // luu lai
            aircraftRepository.save(aircraft);

            return ResponseEntity.ok(aircraftService.getAircraftInfo(aircraft));
        } catch (Exception e) {
            log.debug("edit aircraft error: " + e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PreAuthorize("hasRole('ADMIN_AIRCRAFT')")
    @DeleteMapping("/delete_aircraft")
    @Transactional
    public ResponseEntity<?> deleteAircraft(@RequestParam(name = "serial_number") String serialNumber) {
        try {
            aircraftRepository.delete(aircraftRepository.findBySerialNumber(serialNumber));
            return ResponseEntity.ok().body("Xoá thành công");
        } catch (Exception e) {
            log.debug(e.getMessage());
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
