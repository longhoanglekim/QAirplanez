package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.BusinessCabbageInfo;
import com.web.airplane.demo.dtos.EconomyCabbageInfo;
import com.web.airplane.demo.models.TicketClass;
import com.web.airplane.demo.repositories.TicketClassRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/ticket_class")
public class TicketClassController {
    private final TicketClassRepository ticketClassRepository;

    public TicketClassController(TicketClassRepository ticketClassRepository) {
        this.ticketClassRepository = ticketClassRepository;
    }

    @GetMapping("/economy")
    public EconomyCabbageInfo getEconomyCabbageInfo() {
        TicketClass ticketClass = ticketClassRepository.getTicketClassByClassName("economy");
        return new EconomyCabbageInfo(ticketClass.getHandBaggageWeight(), ticketClass.getHandBaggageCount(),
                ticketClass.getHandBaggageWeight(), ticketClass.getCheckedBaggageCount());
    }

    @GetMapping("/business")
    public BusinessCabbageInfo getBusinessCabbageInfo() {
        TicketClass ticketClass = ticketClassRepository.getTicketClassByClassName("business");
        return new BusinessCabbageInfo(ticketClass.getHandBaggageWeight(), ticketClass.getHandBaggageCount(),
                ticketClass.getHandBaggageWeight(), ticketClass.getCheckedBaggageCount());
    }
}
