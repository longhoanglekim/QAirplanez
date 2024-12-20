package com.web.airplane.demo.dtos.bookings;


import com.web.airplane.demo.dtos.PassengerInfo;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class TicketResponse {
    private String bookingCode;
    private FlightResponse outboundFlight;
    private FlightResponse inboundFlight;
    private List<PassengerInfo> passengerInfoList;
    private String service;
    private BigDecimal price;

}
