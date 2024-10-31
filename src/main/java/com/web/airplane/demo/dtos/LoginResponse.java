package com.web.airplane.demo.dtos;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
@Getter
public class LoginResponse {
    private String token;
    private Long expiresIn;
    private String error; // Thêm trường error

    public LoginResponse setToken(String token) {
        this.token = token;
        return this;
    }

    public LoginResponse setExpiresIn(Long expiresIn) {
        this.expiresIn = expiresIn;
        return this;
    }

    public LoginResponse setError(String error) {
        this.error = error;
        return this;
    }


}
