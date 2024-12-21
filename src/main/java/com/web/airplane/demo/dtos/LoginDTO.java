package com.web.airplane.demo.dtos;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class LoginDTO {

    @Pattern(regexp = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$|^\\d{10}$",
            message = "Username phải là một email hợp lệ hoặc số điện thoại hợp lệ (chỉ bao gồm 10 chữ số)")
    private String username;

    @Size(min = 6, message = "Mật khẩu phải có ít nhất 6 ký tự.")
    @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "Mật khẩu chỉ được chứa chữ cái và số.")
    private String password;
}
