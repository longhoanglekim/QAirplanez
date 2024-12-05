package com.web.airplane.demo.dtos;


import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@NoArgsConstructor
@Setter
@Getter
public class PassengerInfo {
    private String firstName;
    private String lastName;
    private String ticketClassCode;
    private LocalDate birthdate;
    private String identification;
    private Integer seatRow;
    private String seatPosition;
}
