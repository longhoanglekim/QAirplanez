package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.FlightNotification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FlightNotificationRepository extends JpaRepository<FlightNotification, Long> {
}
