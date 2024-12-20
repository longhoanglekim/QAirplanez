package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.BookingTicket;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookingTicketRepository extends JpaRepository<BookingTicket, Long> {
    BookingTicket findBookingTicketByBookingCode(String code);
}
