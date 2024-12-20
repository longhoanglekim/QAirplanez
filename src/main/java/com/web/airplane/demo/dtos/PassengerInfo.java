package com.web.airplane.demo.dtos;


import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@NoArgsConstructor
@Setter
@Getter
public class PassengerInfo {
    private String firstName;
    private String lastName;
    private String ticketClassCode;
    private LocalDate birthdate;

    private String bookingCode;
    private Integer seatRow;
    private String seatPosition;
    private String flightNumber;
    private String identification;
    private String email;
    private String phoneNumber;

    public String getFullName() {
        return firstName + " " + lastName;
    }

    public String getSeatCode() {
        return seatPosition + seatRow;
    }
}
