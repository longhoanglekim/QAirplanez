package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.FlightInfo;

import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.repositories.AirportRepository;
import com.web.airplane.demo.repositories.FlightRepository;
import com.web.airplane.demo.repositories.PassengerRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class FlightService {
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private AircraftRepository aircraftRepository;
    @Autowired
    private AirportRepository airportRepository;
    @Autowired
    private PassengerRepository passengerRepository;
    // Phương thức tạo flight mới mà không cần actual times và passengers
    public Flight createFlight(FlightInfo flightInfo) {

        // Tạo đối tượng Flight với các thông tin cần thiết
        Flight flight = new Flight();
        flight.setFlightNumber(flightInfo.getFlightNumber());
        flight.setDepartureAirport(airportRepository.findByAirportCode(flightInfo.getDepartureCode()));
        log.debug("Departure airport " + flightInfo.getDepartureCode() +":" + airportRepository.findByAirportCode(flightInfo.getDepartureCode()));
        flight.setDestinationAirport(airportRepository.findByAirportCode(flightInfo.getAircraftCode()));
        flight.setExpectedDepartureTime(flightInfo.getExpectedDepartureTime());
        flight.setExpectedArrivalTime(flightInfo.getExpectedArrivalTime());
        flight.setAircraft(aircraftRepository.findBySerialNumber(flightInfo.getTailNumber()));
        flight.setCancelDueTime(flightInfo.getCancelDueTime());

        // Lưu vào cơ sở dữ liệu
        return flightRepository.save(flight);
    }

    public FlightInfo getFlightInfo(Flight flight) {
        FlightInfo flightInfo = new FlightInfo();
        flightInfo.setFlightNumber(flight.getFlightNumber());
        flightInfo.setAircraftCode(flight.getAircraft().getManufacturer() + "-" + flight.getAircraft().getModel());
        flightInfo.setDepartureCode(flight.getDepartureAirport().getAirportCode());
        flightInfo.setArrivalCode(flight.getDestinationAirport().getAirportCode());
        flightInfo.setExpectedArrivalTime(flight.getExpectedArrivalTime());
        flightInfo.setExpectedDepartureTime(flight.getExpectedDepartureTime());
        flightInfo.setCancelDueTime(flight.getCancelDueTime());
        flightInfo.setAvailableFirstSeats(flight.getFirstAvailableSeats() > 0);
        flightInfo.setAvailableBusinessSeats(flight.getBusinessAvailableSeats() > 0);
        flightInfo.setAvailableEconomySeats(flight.getEconomyAvailableSeats() > 0);
        flightInfo.setStatus(flight.getStatus());
        flightInfo.setTailNumber(flight.getAircraft().getSerialNumber());
        return flightInfo;
    }

    public String getFirstSeatForAutoBooking(Flight flight) {
        for (int row = 1; row <= getMaxFirstRow(flight); row++) {
            // Vòng lặp qua các cột ghế từ A đến F
            log.debug("Chon hang ghe");
            for (char col ='A'; col <= 'F'; col++) {
                if (passengerRepository.findPassengerIfSeatBooked(flight.getId(), row, String.valueOf(col)) == null) {
                    log.debug("Thay ghe");
                    return col + String.valueOf(row);
                }
            }
        }
        return null;
    }

    public String getBusinessSeatForAutoBooking(Flight flight) {
        for (int row = getMaxFirstRow(flight) + 1; row <= getMaxBusinessRow(flight); row++) {
            // Vòng lặp qua các cột ghế từ A đến F
            for (char col ='A'; col <= 'F'; col++) {
                if (passengerRepository.findPassengerIfSeatBooked(flight.getId(), row, String.valueOf(col)) == null) {
                    return col + String.valueOf(row);
                }
            }
        }
        return null;
    }

    public String getEconomySeatForAutoBooking(Flight flight) {
        for (int row = getMaxBusinessRow(flight) + 1; row <= getMaxFirstRow(flight); row++) {
            // Vòng lặp qua các cột ghế từ A đến F
            for (char col ='A'; col <= 'F'; col++) {
                if (passengerRepository.findPassengerIfSeatBooked(flight.getId(), row, String.valueOf(col)) == null) {
                    return col + String.valueOf(row);
                }
            }
        }
        return null;
    }






    private int getMaxFirstRow(Flight flight) {
        int maxFirstSeats = (int) ((flight.getAircraft().getNumberOfSeats()) * 0.1);
        return maxFirstSeats/6;
    }

    private int getMaxBusinessRow(Flight flight) {
        int maxBusinessSeats = (int) ((flight.getAircraft().getNumberOfSeats()) * 0.2) ;
        return getMaxFirstRow(flight) + maxBusinessSeats/6;
    }

    private int getMaxEconomyRow(Flight flight) {
        return flight.getAircraft().getNumberOfSeats()/6;
    }





}