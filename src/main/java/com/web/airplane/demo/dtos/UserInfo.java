package com.web.airplane.demo.dtos;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
public class UserInfo {
    private String firstname;
    private String lastname;
    private Date birthdate;
    private String email;
    private String phoneNumber;
    private String identification;
    private String nationality;
}
