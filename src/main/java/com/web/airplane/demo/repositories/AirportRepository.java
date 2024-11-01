package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Airport;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AirportRepository extends JpaRepository<Airport, Long> {
}
