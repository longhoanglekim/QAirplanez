package com.web.airplane.demo.dtos.bookings;

import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.Period;
@Getter
@Setter
@NoArgsConstructor
public class PassengerTicketInfo {
    private String firstName;
    private String lastName;
    private String TicketClassCode;
    private LocalDate birthdate;

    private String bookingCode;
    private String SeatCode;
    private String flightNumber;
    private String identification;
    private String email;
    private String phoneNumber;

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public boolean isAdult() {

        LocalDate today = LocalDate.now();
        int age = Period.between(birthdate, today).getYears(); // Tính số năm

        return age >= 18;
    }
}
