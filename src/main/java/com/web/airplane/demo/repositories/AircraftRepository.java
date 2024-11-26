package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Aircraft;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AircraftRepository extends JpaRepository<Aircraft, Long> {
    Aircraft findByManufacturerAndModel(String manufacture, String model);
}
