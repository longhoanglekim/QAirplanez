package com.web.airplane.demo.dtos.bookings;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Getter
@Setter
@NoArgsConstructor
public class AdultResponse extends ChildResponse {
    private String identification;
    private String email;
    private String phoneNumber;
}
