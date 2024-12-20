package com.web.airplane.demo.dtos.bookings;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;


@Getter
@Setter
@NoArgsConstructor
public class FlightResponse {
    private String flightNumber;
    private String serialNumber;
    private LocalDateTime departTime;
    private LocalDateTime arrivalTime;
    private LocalDateTime cancelTime;
    private String departAirportCode;
    private String arrivalAirportCode;
    private String status;
}
