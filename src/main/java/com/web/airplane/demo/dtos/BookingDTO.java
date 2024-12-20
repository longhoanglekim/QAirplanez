package com.web.airplane.demo.dtos;

import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Setter
@Getter
public class BookingDTO {
    private List<PassengerInfo> passengerInfoList;
    private String departFlightNumber;
    private String returnFlightNumber;
    private String allService;
    private String totalPrice;
}

