package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    public List<Passenger> findAllByEmail(String email);
}
