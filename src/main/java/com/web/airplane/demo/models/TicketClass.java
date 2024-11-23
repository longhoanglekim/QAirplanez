package com.web.airplane.demo.models;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Setter
@Getter
@Table(name = "ticket_classes")

public class TicketClass {
    @Id
    private Long id;

    @OneToMany(mappedBy = "ticketClass")
    private List<Passenger> passengerList = new ArrayList<>();
}
