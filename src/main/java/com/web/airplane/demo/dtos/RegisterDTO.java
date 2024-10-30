package com.web.airplane.demo.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@AllArgsConstructor
@Getter
@Setter
public class RegisterDTO {
    private String password;
    private String firstname;
    private String lastname;
    private Date birthdate;
    private String phoneNumber;
    private String email;
}
