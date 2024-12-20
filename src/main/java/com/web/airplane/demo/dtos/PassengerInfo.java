package com.web.airplane.demo.dtos;


import com.web.airplane.demo.models.Passenger;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.Period;

@NoArgsConstructor
@Setter
@Getter
public class PassengerInfo {
    private String firstName;
    private String lastName;
    private String outboundTicketClassCode;
    private String inboundTicketClassCode;
    private LocalDate birthdate;

    private String bookingCode;
    private String outboundSeatCode;
    private String inboundSeatCode;
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

