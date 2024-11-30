package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.DestinationInfo;
import com.web.airplane.demo.models.Airport;
import com.web.airplane.demo.repositories.AirportRepository;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/airport")
public class AirportController {
    private final AirportRepository airportRepository;

    public AirportController(AirportRepository airportRepository) {
        this.airportRepository = airportRepository;
    }

    @GetMapping("/public/destination")
    public List<DestinationInfo> getAllDestination() {
        List<Airport> airportList = airportRepository.findAllAirport();
        List<DestinationInfo> destinationInfos = new ArrayList<>();
        for (Airport airport : airportList) {
            DestinationInfo destinationInfo = new DestinationInfo();
            destinationInfo.setDescription(airport.getDescription());
            destinationInfo.setCity(airport.getCity());
            destinationInfo.setCountry(airport.getCountry().getCountryName());
            destinationInfo.setImage(airport.getImageLink());
            destinationInfos.add(destinationInfo);
        }
        return destinationInfos;

    }
}
