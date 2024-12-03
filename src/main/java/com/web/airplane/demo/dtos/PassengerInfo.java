package com.web.airplane.demo.dtos;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Setter
@Getter
public class PassengerInfo {
    private String firstName;
    private String lastName;
    private String ticketClassCode;
    private Boolean isAdult;
    private String identification;
}
