package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Airport;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AirportRepository extends JpaRepository<Airport, Long> {
    public Airport findByAirportCode(String code);

    @Query(value = "SELECT * FROM airports", nativeQuery = true)
    public List<Airport> findAllAirport();

    @Query(value = "SELECT DISTINCT city FROM airports", nativeQuery = true)
    public List<String> getAllCity();
}
