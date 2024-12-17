package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Aircraft;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AircraftRepository extends JpaRepository<Aircraft, Long> {
    Optional<Aircraft> findTopByOrderBySerialNumberDesc();
    Aircraft findBySerialNumber(String number);
    Optional<Aircraft> findFirstBySerialNumberStartingWithOrderBySerialNumberDesc(String prefix);
}
