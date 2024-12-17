package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.AircraftInfo;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.repositories.AircraftRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AircraftService {
    @Autowired
    private AircraftRepository aircraftRepository;
    public AircraftInfo getAircraftInfo(Aircraft aircraft) {
        AircraftInfo aircraftInfo = new AircraftInfo();
        aircraftInfo.setNumberOfSeats(aircraft.getNumberOfSeats());
        aircraftInfo.setManufacturer(aircraft.getManufacturer());
        aircraftInfo.setModel(aircraft.getModel());
        aircraftInfo.setStatus(aircraft.getStatus());
        aircraftInfo.setSerialNumber(aircraft.getSerialNumber());
        return aircraftInfo;
    }
    private String generateSerialNumber(String manufacture) {
        String prefix = String.valueOf(manufacture.charAt(0));
        
        // Lấy số serial number lớn nhất cho manufacturer cụ thể
        String lastTailNumber = aircraftRepository.findFirstBySerialNumberStartingWithOrderBySerialNumberDesc(prefix)
            .map(Aircraft::getSerialNumber)
            .orElse(prefix + "00000");

        // Trích xuất phần số và tăng lên 1
        int nextNumber = Integer.parseInt(lastTailNumber.substring(1)) + 1;
        return prefix.toUpperCase() + String.format("%05d", nextNumber);
    }

    public String createAircraft(AircraftInfo aircraftInfo) {
        Aircraft aircraft = new Aircraft();
        aircraft.setStatus(aircraftInfo.getStatus());
        aircraft.setModel(aircraftInfo.getModel());
        aircraft.setManufacturer(aircraftInfo.getManufacturer());
        aircraft.setFlights(null);
        aircraft.setNumberOfSeats(aircraftInfo.getNumberOfSeats());
        aircraft.setSerialNumber(generateSerialNumber(aircraftInfo.getManufacturer()));
        aircraftRepository.save(aircraft);
        return aircraft.getSerialNumber();
    }
}
