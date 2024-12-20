package com.web.airplane.demo.models;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "flights")
@Getter
@Setter
@NoArgsConstructor
public class Flight {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String flightNumber;
    @ManyToOne
    private Airport departureAirport;
    @ManyToOne
    private Airport destinationAirport;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime expectedDepartureTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime expectedArrivalTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime actualDepartureTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime actualArrivalTime;

    @ManyToOne
    Aircraft aircraft;

    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime cancelDueTime;

    @NotNull(message = "Số ghế hạng phổ thông không được null")
    @Min(value = 0, message = "Số ghế hạng phổ thông phải lớn hơn hoặc bằng 0")
    private int economyAvailableSeats;

    @NotNull(message = "Số ghế hạng thương gia không được null")
    @Min(value = 0, message = "Số ghế hạng thương gia phải lớn hơn hoặc bằng 0")
    private int businessAvailableSeats;

    @NotNull(message = "Số ghế hạng nhất không được null")
    @Min(value = 0, message = "Số ghế hạng nhất phải lớn hơn hoặc bằng 0")
    private int firstAvailableSeats;

    @Column(nullable = false, columnDefinition = "varchar(255) DEFAULT 'Scheduled'")
    private String status;

    @OneToMany(mappedBy = "flight", cascade = CascadeType.ALL, orphanRemoval = true)
    List<Passenger> passengers = new ArrayList<>();

    public Flight(String flightNumber, Airport departureAirport, Airport destinationAirport,
                  LocalDateTime expectedDepartureTime, LocalDateTime expectedArrivalTime, Aircraft aircraft, List<Passenger> passengers) {
        this.flightNumber = flightNumber;
        this.departureAirport = departureAirport;
        this.destinationAirport = destinationAirport;
        this.expectedDepartureTime = expectedDepartureTime;
        this.expectedArrivalTime = expectedArrivalTime;
        this.aircraft = aircraft;
        this.passengers = passengers;
    }
}
