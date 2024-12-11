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
        aircraftInfo.setManufacturer(aircraftInfo.getManufacturer());
        aircraftInfo.setModel(aircraftInfo.getModel());
        aircraftInfo.setStatus(aircraftInfo.getStatus());
        return aircraftInfo;
    }
    private String generateSerialNumber(String manufacture) {
        // Lấy số đăng ký lớn nhất trong bảng Aircraft
        String lastTailNumber = aircraftRepository.findTopByOrderBySerialNumberDesc().map(Aircraft::getSerialNumber).orElse(manufacture.charAt(0) + "00000");

        // Trích xuất phần số trong tailNumber và cộng thêm 1
        int nextNumber = Integer.parseInt(lastTailNumber.substring(1)) + 1;  // Lấy phần số từ tail number (bỏ chữ 'N')

        // Tạo tail number mới
        return manufacture.charAt(0) + String.format("%05d", nextNumber);  // Đảm bảo có 5 chữ số
    }

    public void createAircraft(AircraftInfo aircraftInfo) {
        Aircraft aircraft = new Aircraft();
        aircraft.setStatus(aircraft.getStatus());
        aircraft.setModel(aircraftInfo.getModel());
        aircraft.setManufacturer(aircraft.getManufacturer());
        aircraft.setFlights(null);
        aircraft.setNumberOfSeats(aircraftInfo.getNumberOfSeats());
        aircraft.setSerialNumber(generateSerialNumber(aircraftInfo.getManufacturer()));
        aircraftRepository.save(aircraft);
    }
}
