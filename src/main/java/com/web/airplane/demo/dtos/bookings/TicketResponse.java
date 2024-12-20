package com.web.airplane.demo.dtos.bookings;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class TicketResponse {
    private String bookingCode;
    private FlightResponse outboundFlight;
    private FlightResponse inboundFlight;
    private List<AdultResponse> adultResponseList;
    private List<ChildResponse> childResponseList;
    private String service;

}
