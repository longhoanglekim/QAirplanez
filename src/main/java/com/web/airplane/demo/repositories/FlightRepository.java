package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Flight;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FlightRepository extends JpaRepository<Flight, Long> {
}
