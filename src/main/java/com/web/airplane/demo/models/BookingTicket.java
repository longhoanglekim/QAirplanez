package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "booking_tickets")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BookingTicket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String bookingCode;
    private String service;
    private BigDecimal totalPrice;
    @OneToMany(mappedBy = "bookingTicket", cascade = CascadeType.ALL, orphanRemoval = true)
    List<Passenger> passengers = new ArrayList<>();


}
