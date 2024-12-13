package com.web.airplane.demo.dtos;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class AirportCountryInfoDTO {
    private String airportCode;
    private String airportName;
    private String cityName;
    private String countryCode;
    private String countryName;
}
