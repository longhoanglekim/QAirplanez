package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.BookingTicket;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    public List<Passenger> findAllByEmail(String email);
    Passenger findByPassengerId(long id);
    @Query("SELECT p FROM Passenger p WHERE p.seatRow <= :maxRow AND p.flight = :flight " +
            "ORDER BY p.seatRow DESC, p.seatPosition DESC limit 1")
    Optional<Passenger> findPassengerWithMaxRowLessThanOrEqual(@Param("maxRow") Integer maxRow, @Param("flight") Flight flight);

    boolean existsPassengerByBookingTicket(BookingTicket bookingTicket);

    @Query("SELECT p FROM Passenger p WHERE p.seatRow >= :minRow AND p.seatRow <= :maxRow AND p.flight = :flight " +
            "ORDER BY p.seatRow DESC, p.seatPosition DESC limit 1")
    Optional<Passenger> findPassengerWithMaxRowInRange(
            @Param("minRow") Integer minRow,
            @Param("maxRow") Integer maxRow,
            @Param("flight") Flight flight);

    @Query(value = "SELECT p FROM Passenger p WHERE p.flight.id = :flightId AND p.seatRow = :seatRow AND p.seatPosition = :seatPosition", nativeQuery = false)
    Passenger findPassengerIfSeatBooked(Long flightId, Integer seatRow, String seatPosition);

    List<Passenger> findAllByBookingTicket(BookingTicket bookingTicket);

    @Query(value = "SELECT * FROM passengers WHERE booking_ticket_id = :bookingTicketId LIMIT 1", nativeQuery = true)
    Passenger findByBookingTicket(@Param("bookingTicketId") Long bookingTicketId);

    Passenger findBySeatPositionAndSeatRowAndBookingTicket(String seatPosition, Integer row, BookingTicket bookingTicket);
}
