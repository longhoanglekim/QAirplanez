package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.TicketClass;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TicketClassRepository extends JpaRepository<TicketClass, Long> {
    TicketClass getTicketClassByClassName(String className);
}
