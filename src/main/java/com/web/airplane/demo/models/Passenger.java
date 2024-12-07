package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

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
    private LocalDate birthdate;

    @NotNull
    private Integer seatRow;

    @NotBlank
    private String seatPosition;

    @NotNull
    @ManyToOne
    private Flight flight;

    private String identification;

    private String bookingCode;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
