package com.web.airplane.demo.dtos;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@AllArgsConstructor
@Getter
@Setter
public class RegisterDTO {
    @Size(min = 6, message = "Mật khẩu phải có ít nhất 6 ký tự.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "Mật khẩu chỉ được chứa chữ cái và số.")
    private String password;
    private String firstname;
    private String lastname;
    private Date birthdate;

    @Pattern(regexp = "^\\d{10}$", message = "Số điện thoại phải có đủ 10 chữ số")
    private String phoneNumber;

    @Email(message = "Cần nhập đúng định dạng email!")
    private String email;
}
