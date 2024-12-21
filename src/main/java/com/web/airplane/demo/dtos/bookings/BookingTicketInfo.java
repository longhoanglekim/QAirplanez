package com.web.airplane.demo.dtos.bookings;

import com.web.airplane.demo.models.Passenger;
import jakarta.persistence.CascadeType;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;


@Getter
@Setter
@NoArgsConstructor
public class BookingTicketInfo {
    private String bookingCode;
    private BigDecimal totalPrice;
    private LocalDate bookingDate;
    private int passengerSize;
}
