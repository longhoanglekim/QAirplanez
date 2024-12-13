package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.AirportCountryInfoDTO;
import com.web.airplane.demo.dtos.AirportInfo;
import com.web.airplane.demo.models.Airport;
import com.web.airplane.demo.repositories.AirportRepository;
import com.web.airplane.demo.services.AirportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/airport")
public class AirportController {
    @Autowired
    private AirportService airportService;
    private final AirportRepository airportRepository;

    public AirportController(AirportRepository airportRepository) {
        this.airportRepository = airportRepository;
    }


    @GetMapping("/public/airportList")
    public List<AirportInfo> getAllAirport() {
        List<Airport> airportList = airportRepository.findAllAirport();
        List<AirportInfo> airportInfos = new ArrayList<>();
        for (Airport airport : airportList) {
            AirportInfo airportInfo = airportService.getAirportInfo(airport);
            airportInfos.add(airportInfo);
        }
        return airportInfos;

    }

    @GetMapping("/public/airportListByCountry")
    public List<AirportCountryInfoDTO> getAllAirportWithAirportInfosCountry() {
        List<Object[]> airportList = airportRepository.findAllAirportsWithCountry();
        List<AirportCountryInfoDTO> airportCountryInfoDTOs = new ArrayList<>();
        for (Object[] airport : airportList) {
            AirportCountryInfoDTO airportCountryInfoDTO = new AirportCountryInfoDTO();
            airportCountryInfoDTO.setAirportCode(airport[1].toString());
            airportCountryInfoDTO.setAirportName(airport[2].toString());
            airportCountryInfoDTO.setCityName(airport[3].toString());
            airportCountryInfoDTO.setCountryCode(airport[4].toString());
            airportCountryInfoDTO.setCountryName(airport[8].toString());
            airportCountryInfoDTOs.add(airportCountryInfoDTO);
        }
        return airportCountryInfoDTOs;
    }
}
