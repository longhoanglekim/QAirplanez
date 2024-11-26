package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Aircraft;
import com.web.airplane.demo.models.Airport;
import com.web.airplane.demo.models.Flight;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDateTime;
import java.util.List;

public interface FlightRepository extends JpaRepository<Flight, Long> {
    boolean existsByExpectedArrivalTimeAndFlightNumberAndAircraft(
            LocalDateTime expectedArrivalTime,
            String flightNumber,
            Aircraft aircraft);
    List<Flight> findAllByDepartureAirportAndDestinationAirport(Airport dep, Airport des);
    Flight findByFlightNumber(String number);
}
