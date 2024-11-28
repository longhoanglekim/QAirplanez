package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name="passengers")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Passenger {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long passengerId;
    @NotBlank
    private String firstName;
    @NotBlank
    private String lastName;

    private String phoneNumber;

    private String passportNumber;

    private String email;

    @NotNull
    @ManyToOne
    private TicketClass ticketClass;


    private String bankName;
    private boolean isAdult;

    @NotNull
    private Integer seatRow;

    @NotBlank
    private String seatPosition;

    @NotNull
    @ManyToOne
    private Flight flight;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
