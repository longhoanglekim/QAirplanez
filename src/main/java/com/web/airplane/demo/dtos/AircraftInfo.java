package com.web.airplane.demo.dtos;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AircraftInfo {
    private String manufacturer;
    private String model;
    private Integer numberOfSeats;
    private String status;
}
