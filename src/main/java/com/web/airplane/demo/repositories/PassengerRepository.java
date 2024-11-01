package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PassengerRepository extends JpaRepository<Passenger, Long> {
}
