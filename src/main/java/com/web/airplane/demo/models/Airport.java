package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
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
    private int id;
    @NotBlank
    @Size(min = 3, max = 3, message = "Mã sân bay chỉ có thể có 3 kí tự")
    @Pattern(regexp = "^[A-Z]+$", message = "Mã sân bay phải viết hoa tất cả các ký tự.")
    private String airportCode;
    @NotBlank
    private String airportName;
    @NotBlank
    private String city;
    @NotNull
    @ManyToOne
    private Country country;
    @NotNull
    private String imageLink;

    @NotNull
    private String description;

    @OneToMany(mappedBy = "departureAirport", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Flight> departingFlights = new ArrayList<>();

    @OneToMany(mappedBy = "destinationAirport", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Flight> arrivingFlights = new ArrayList<>();


}
