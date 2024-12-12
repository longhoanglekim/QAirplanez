package com.web.airplane.demo.dtos;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AirportInfo {
    private String airportCode;
    private String image;
    private String city;
    private String description;
    private String country;
}
