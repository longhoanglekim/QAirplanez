package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.AircraftInfo;
import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.models.Flight;
import org.springframework.stereotype.Service;

@Service
public class AircraftService {
    public AircraftInfo getAircraftInfo(Aircraft aircraft) {
        AircraftInfo aircraftInfo = new AircraftInfo();
        aircraftInfo.setNumberOfSeats(aircraft.getNumberOfSeats());
        aircraftInfo.setManufacturer(aircraftInfo.getManufacturer());
        aircraftInfo.setModel(aircraftInfo.getModel());
        aircraftInfo.setStatus(aircraftInfo.getStatus());
        return aircraftInfo;
    }
}
