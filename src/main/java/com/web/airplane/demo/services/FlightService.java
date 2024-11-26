package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.FlightInfo;
import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.models.Airport;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.repositories.AircraftRepository;
import com.web.airplane.demo.repositories.AirportRepository;
import com.web.airplane.demo.repositories.FlightRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class FlightService {
    @Autowired
    private FlightRepository flightRepository;
    @Autowired
    private AircraftRepository aircraftRepository;
    @Autowired
    private AirportRepository airportRepository;
    // Phương thức tạo flight mới mà không cần actual times và passengers
    public Flight createFlight(FlightInfo flightInfo) {

        // Tạo đối tượng Flight với các thông tin cần thiết
        Flight flight = new Flight();
        flight.setFlightNumber(flightInfo.getFlightNumber());
        flight.setDepartureAirport(airportRepository.findByAirportCode(flightInfo.getDepartureAirportCode()));
        log.debug("Departure airport " + flightInfo.getDepartureAirportCode() +":" + airportRepository.findByAirportCode(flightInfo.getDepartureAirportCode()));
        flight.setDestinationAirport(airportRepository.findByAirportCode(flightInfo.getDestinationAirportCode()));
        flight.setExpectedDepartureTime(flightInfo.getExpectedDepartureTime());
        flight.setExpectedArrivalTime(flightInfo.getExpectedArrivalTime());
        flight.setAircraft(aircraftRepository.findByManufacturerAndModel(flightInfo.getManufacture(), flightInfo.getModel()));
        flight.setCancelDueTime(flightInfo.getCancelDueTime());

        // Lưu vào cơ sở dữ liệu
        return flightRepository.save(flight);
    }

    public FlightInfo getFlightInfo(Flight flight) {
        FlightInfo flightInfo = new FlightInfo();
        flightInfo.setFlightNumber(flight.getFlightNumber());
        flightInfo.setAircraftCode(flight.getAircraft().getManufacturer() + "-" + flight.getAircraft().getModel());
        flightInfo.setDepartureAirportCode(flight.getDepartureAirport().getAirportCode());
        flightInfo.setDestinationAirportCode(flight.getDestinationAirport().getAirportCode());
        flightInfo.setExpectedArrivalTime(flight.getExpectedArrivalTime());
        flightInfo.setExpectedDepartureTime(flight.getExpectedDepartureTime());
        flightInfo.setActualArrivalTime(flight.getActualArrivalTime());
        flightInfo.setActualDepartureTime(flight.getActualDepartureTime());
        flightInfo.setCancelDueTime(flight.getCancelDueTime());
        return flightInfo;
    }
}
