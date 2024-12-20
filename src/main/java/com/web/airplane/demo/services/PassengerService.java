package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.dtos.bookings.AdultResponse;
import com.web.airplane.demo.dtos.bookings.ChildResponse;
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
        passengerInfo.setBookingCode(passenger.getBookingTicket().getBookingCode());
        passengerInfo.setOutboundTicketClassCode(passenger.getTicketClass().getClassName());
        passengerInfo.setOutboundSeatCode(passenger.getSeatPosition() + passenger.getSeatRow());
        passengerInfo.setFlightNumber(passenger.getFlight().getFlightNumber());
        return passengerInfo;
    }

    public ChildResponse getChildInfo(Passenger passenger) {
        ChildResponse childResponse = new ChildResponse();
        childResponse.setBirthdate(passenger.getBirthdate());
        childResponse.setBookingCode(passenger.getBookingTicket().getBookingCode());
        childResponse.setSeatCode(passenger.getSeatPosition() + "-" + passenger.getSeatRow());
        childResponse.setFirstName(passenger.getFirstName());
        childResponse.setLastName(passenger.getLastName());
        childResponse.setTicketClassCode(passenger.getTicketClass().getClassName());
        return childResponse;
    }

    public AdultResponse getAdultInfo(Passenger passenger) {
        AdultResponse adultResponse = new AdultResponse();
        adultResponse.setBirthdate(passenger.getBirthdate());
        adultResponse.setBookingCode(passenger.getBookingTicket().getBookingCode());
        adultResponse.setSeatCode(passenger.getSeatPosition() + "-" + passenger.getSeatRow());
        adultResponse.setFirstName(passenger.getFirstName());
        adultResponse.setLastName(passenger.getLastName());
        adultResponse.setTicketClassCode(passenger.getTicketClass().getClassName());
        adultResponse.setEmail(passenger.getEmail());
        adultResponse.setPhoneNumber(passenger.getPhoneNumber());
        adultResponse.setIdentification(adultResponse.getIdentification());
        return adultResponse;
    }
}
