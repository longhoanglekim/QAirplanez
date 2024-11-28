package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.AircraftInfo;
import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.LoginResponse;
import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.exceptions.AccountAlreadyExistedException;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.AuthenticationService;
import com.web.airplane.demo.services.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/api/aircraft")
@Slf4j
public class AircraftController {
    private AircraftRepository aircraftRepository;
    public AircraftController(AircraftRepository __aircraftRepository) {
        this.aircraftRepository = __aircraftRepository;
    } 

    @PostMapping("/addAircraft")
    public ResponseEntity<?> addAircraft(@RequestBody AircraftInfo aircraftAdded) {
        Aircraft newAircraft = new Aircraft();
        newAircraft.setManufacturer(aircraftAdded.getManufacturer());
        newAircraft.setModel(aircraftAdded.getModel());
        newAircraft.setNumberOfSeats(aircraftAdded.getNumberOfSeats());

        return ResponseEntity.ok().body(newAircraft);
    }
}
