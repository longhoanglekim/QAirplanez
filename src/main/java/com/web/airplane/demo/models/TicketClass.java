package com.web.airplane.demo.models;

import jakarta.persistence.*;
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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "class_name", nullable = false, length = 255)
    private String className;

    @Column(name = "description", length = 255)
    private String description;

    @Column(name = "price_multiplier", nullable = false, precision = 5)
    private Double priceMultiplier;

    @Column(name = "hand_baggage_weight", precision = 5)
    private Double handBaggageWeight;

    @Column(name = "hand_baggage_count")
    private Integer handBaggageCount;

    @Column(name = "checked_baggage_weight", precision = 5)
    private Double checkedBaggageWeight;

    @Column(name = "checked_baggage_count")
    private Integer checkedBaggageCount;
    @OneToMany(mappedBy = "ticketClass")
    private List<Passenger> passengerList = new ArrayList<>();
}
