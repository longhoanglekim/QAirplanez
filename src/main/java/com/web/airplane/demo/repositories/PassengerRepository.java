package com.web.airplane.demo.repositories;

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
    @Query("SELECT p FROM Passenger p WHERE p.row <= :maxRow AND p.flight = :flight " +
            "ORDER BY p.row DESC, p.seatPosition DESC")
    Optional<Passenger> findPassengerWithMaxRowLessThanOrEqual(@Param("maxRow") Integer maxRow, @Param("flight") Flight flight);

    @Query("SELECT p FROM Passenger p WHERE p.row >= :minRow AND p.row <= :maxRow AND p.flight = :flight " +
            "ORDER BY p.row DESC, p.seatPosition DESC")
    Optional<Passenger> findPassengerWithMaxRowInRange(
            @Param("minRow") Integer minRow,
            @Param("maxRow") Integer maxRow,
            @Param("flight") Flight flight);

}
