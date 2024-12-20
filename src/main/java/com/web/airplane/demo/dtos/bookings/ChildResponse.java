package com.web.airplane.demo.dtos.bookings;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;


@Getter
@Setter
@NoArgsConstructor
public class ChildResponse {
    private String firstName;
    private String lastName;
    private String ticketClassCode;
    private LocalDate birthdate;
    private String bookingCode;
    private String seatCode;
}
