package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "airports")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Airport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @NotBlank
    private int airportId;
    @NotBlank
    private String airportCode;
    @NotBlank
    private String airportName;
    @NotBlank
    private String city;
    @NotBlank
    private String country;


    @OneToMany(mappedBy = "departureAirport")
    List<Flight> flights = new ArrayList<>();
}
