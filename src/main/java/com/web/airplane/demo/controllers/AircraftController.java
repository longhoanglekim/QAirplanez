package com.web.airplane.demo.controllers;


import com.web.airplane.demo.dtos.AircraftInfo;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.repositories.AircraftRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/aircraft")
public class AircraftController {

    private final AircraftRepository aircraftRepository;

    public AircraftController(AircraftRepository aircraftRepository) {
        this.aircraftRepository = aircraftRepository;
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @PostMapping("/admin/addAircraft")
    public ResponseEntity<?> addAircraft(AircraftInfo aircraftInfo) {
        Aircraft aircraft = new Aircraft();
        aircraft.setActive(aircraftInfo.getIsActive());
        aircraft.setModel(aircraftInfo.getModel());
        aircraft.setManufacturer(aircraft.getManufacturer());
        aircraft.setFlights(null);
        aircraft.setNumberOfSeats(aircraftInfo.getNumberOfSeats());
        return ResponseEntity.ok(aircraft);
    }
}
