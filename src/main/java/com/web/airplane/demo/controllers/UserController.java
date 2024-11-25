package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.UserService;
import com.web.airplane.demo.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserController {
    private final UserRepository userRepository;
    private final UserService userService;

    public UserController(UserRepository userRepository, UserService userService) {
        this.userRepository = userRepository;
        this.userService = userService;
    }

    @GetMapping("/flights")
    public List<FlightInfo> getFlightInfo(HttpServletRequest request) {
        List<Flight> flights = userService.findAllFlight(userService.getCurrentUser(request));
        List<FlightInfo> flightInfos = new ArrayList<>();
        for (Flight flight : flights) {
            FlightInfo flightInfo = getFlightInfo(flight);
            flightInfos.add(flightInfo);
        }
        return flightInfos;
    }

    @GetMapping("/currentUser")
    public User getCurrentUser(HttpServletRequest request) {
        return userService.getCurrentUser(request);
    }

    private FlightInfo getFlightInfo(Flight flight) {
        FlightInfo flightInfo = new FlightInfo();
        flightInfo.setFlightNumber(flight.getFlightNumber());
        flightInfo.setAircraftCode(flight.getAircraft().getManufacturer() + "-" + flight.getAircraft().getModel());
        flightInfo.setDepartureAirportCode(flight.getDepartureAirport().getAirportCode());
        flightInfo.setDestinationAirportCode(flight.getDestinationAirport().getAirportCode());
        flightInfo.setExpectedArrivalTime(flight.getExpectedArrivalTime());
        flightInfo.setExpectedDepartureTime(flight.getExpectedDepartureTime());
        flightInfo.setActualArrivalTime(flight.getActualArrivalTime());
        flightInfo.setActualDepartureTime(flight.getActualDepartureTime());
        return flightInfo;
    }
}
