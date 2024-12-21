package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Notification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NotificationRepository extends JpaRepository<Notification, Long> {
}
