package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.PassengerInfo;
import com.web.airplane.demo.dtos.bookings.AdultResponse;
import com.web.airplane.demo.dtos.bookings.ChildResponse;
import com.web.airplane.demo.dtos.bookings.PassengerTicketInfo;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.repositories.BookingTicketRepository;
import com.web.airplane.demo.repositories.PassengerRepository;
import com.web.airplane.demo.utils.UserUtil;
import lombok.extern.slf4j.Slf4j;
import org.antlr.v4.runtime.misc.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class PassengerService {
    @Autowired
    private PassengerRepository passengerRepository;

    @Autowired
    private BookingTicketRepository bookingTicketRepository;

    public PassengerInfo getPassengerInfo(Passenger passenger) {
        PassengerInfo passengerInfo = new PassengerInfo();
        passengerInfo.setFirstName(passenger.getFirstName());
        passengerInfo.setLastName(passenger.getLastName());
        passengerInfo.setBirthdate(passenger.getBirthdate());
        passengerInfo.setPhoneNumber(passenger.getPhoneNumber());
        passengerInfo.setIdentification(passenger.getIdentification());
        passengerInfo.setBookingCode(passenger.getBookingTicket().getBookingCode());
        passengerInfo.setOutboundTicketClassCode(passenger.getTicketClass().getClassName());
        passengerInfo.setOutboundSeatCode(passenger.getSeatPosition() + passenger.getSeatRow());
        passengerInfo.setFlightNumber(passenger.getFlight().getFlightNumber());
        passengerInfo.setOutboundTicketClassCode(passengerInfo.getOutboundTicketClassCode());
        passengerInfo.setEmail(passenger.getEmail());
        return passengerInfo;
    }

    public PassengerTicketInfo getPassengerTicketInfo(Passenger passenger) {
        PassengerTicketInfo passengerInfo = new PassengerTicketInfo();
        passengerInfo.setFirstName(passenger.getFirstName());
        passengerInfo.setLastName(passenger.getLastName());
        passengerInfo.setBirthdate(passenger.getBirthdate());
        passengerInfo.setPhoneNumber(passenger.getPhoneNumber());
        passengerInfo.setIdentification(passenger.getIdentification());
        passengerInfo.setBookingCode(passenger.getBookingTicket().getBookingCode());
        passengerInfo.setTicketClassCode(passenger.getTicketClass().getClassName());
        passengerInfo.setSeatCode(passenger.getSeatPosition() + passenger.getSeatRow());
        passengerInfo.setFlightNumber(passenger.getFlight().getFlightNumber());
        passengerInfo.setEmail(passenger.getEmail());
        return passengerInfo;
    }

    public Passenger findByInfo(PassengerTicketInfo passengerTicketInfo) {
        Pair<String, Integer> seatPair = UserUtil.splitString(passengerTicketInfo.getSeatCode());
        log.debug(seatPair.toString());
        return passengerRepository.findBySeatPositionAndSeatRowAndBookingTicket(
                seatPair.a, seatPair.b, bookingTicketRepository.findBookingTicketByBookingCode(passengerTicketInfo.getBookingCode()));
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
        adultResponse.setIdentification(passenger.getIdentification());
        return adultResponse;
    }
}
