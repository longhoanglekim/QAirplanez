package com.web.airplane.demo.dtos;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AircraftInfo {
    private String manufacturer;
    private String model;
    private Integer numberOfSeats;
}
