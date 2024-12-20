package com.web.airplane.demo.dtos.bookings;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class TicketInput {
    private String bookingCode;
    private String firstName;
}
