package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.repositories.PassengerRepository;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.FlightService;
import com.web.airplane.demo.services.UserService;
import com.web.airplane.demo.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserController {
    private final UserRepository userRepository;
    private final UserService userService;
    @Autowired
    private FlightService flightService;
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private PassengerRepository passengerRepository;

    public UserController(UserRepository userRepository, UserService userService) {
        this.userRepository = userRepository;
        this.userService = userService;
    }

    @GetMapping("/flights")
    public List<FlightInfo> getFlightInfo(HttpServletRequest request) {
        List<Flight> flights = userService.findAllFlight(userService.getCurrentUser(request));
        List<FlightInfo> flightInfos = new ArrayList<>();
        for (Flight flight : flights) {
            FlightInfo flightInfo = flightService.getFlightInfo(flight);
            flightInfos.add(flightInfo);
        }
        return flightInfos;
    }

    @GetMapping("/currentUser")
    public User getCurrentUser(HttpServletRequest request) {
        return userService.getCurrentUser(request);
    }


    @PostMapping("/cancel")
    public ResponseEntity<?> cancelFlight(HttpServletRequest request,
                                          @RequestParam("passenger_id") long passengerId,
                                          @RequestParam("flight_number") String flightNumber) {
        // Find the flight by flight number
        Flight flight = flightRepository.findByFlightNumber(flightNumber);
        if (flight == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Flight not found");
        }

        // Find the passenger by passenger ID
        Passenger passenger = passengerRepository.findById(passengerId).orElse(null);
        if (passenger == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Passenger not found");
        }

        // Remove the passenger from the flight's list of passengers
        flight.getPassengers().remove(passenger);

        // Save the flight (cascading the removal of the passenger)
        flightRepository.save(flight);

        return ResponseEntity.ok().body("Passenger has been removed from the flight and deleted");
    }
}
