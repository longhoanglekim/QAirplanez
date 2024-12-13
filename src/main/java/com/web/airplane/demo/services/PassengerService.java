package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.repositories.PassengerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PassengerService {
    @Autowired
    private PassengerRepository passengerRepository;

    public PassengerInfo getPassengerInfo(Passenger passenger) {
        PassengerInfo passengerInfo = new PassengerInfo();
        passengerInfo.setFirstName(passenger.getFirstName());
        passengerInfo.setLastName(passenger.getLastName());
        passengerInfo.setBirthdate(passenger.getBirthdate());
        passengerInfo.setIdentification(passengerInfo.getIdentification());
        passengerInfo.setBookingCode(passenger.getBookingCode());
        passengerInfo.setTicketClassCode(passenger.getTicketClass().getClassName());
        passengerInfo.setSeatPosition(passenger.getSeatPosition());
        passengerInfo.setSeatRow(passenger.getSeatRow());
        passengerInfo.setFlightNumber(passenger.getFlight().getFlightNumber());
        return passengerInfo;
    }
}
