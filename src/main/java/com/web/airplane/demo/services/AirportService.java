package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.AirportInfo;
import com.web.airplane.demo.models.Airport;
import org.springframework.stereotype.Service;

@Service
public class AirportService {


    public AirportInfo getAirportInfo(Airport airport) {
        AirportInfo airportInfo = new AirportInfo();
        airportInfo.setAirportCode(airport.getAirportCode());
        airportInfo.setDescription(airport.getDescription());
        airportInfo.setCity(airport.getCity());
        airportInfo.setCountry(airport.getCountry().getCountryName());
        airportInfo.setImage(airport.getImageLink());
        return airportInfo;
    }
}
