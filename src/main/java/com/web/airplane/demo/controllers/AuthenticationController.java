package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.ChangePasswordDTO;
import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.LoginResponse;
import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.exceptions.AccountAlreadyExistedException;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.AuthenticationService;
import com.web.airplane.demo.services.JwtService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@Slf4j
public class AuthenticationController {

    private final AuthenticationService authenticationService;
    private final JwtService jwtService;

    @Autowired
    public AuthenticationController(UserRepository userRepository, AuthenticationService authenticationService,
            JwtService jwtService) {
        this.authenticationService = authenticationService;
        this.jwtService = jwtService;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterDTO registerAccountDto) {
        // register new account with encoded password

        User newAccount;
        try {
            newAccount = authenticationService.signup(registerAccountDto);
            return ResponseEntity.ok(newAccount);
        } catch (AccountAlreadyExistedException e) {
            return ResponseEntity.status(409).body("Account has already existed!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("");
        }
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> authenticate(@Valid @RequestBody LoginDTO loginUserDto,
            HttpServletResponse response) {
        try {
            User authenticatedUser = authenticationService.authenticate(loginUserDto);

            String jwtToken = jwtService.generateToken(authenticatedUser);

            LoginResponse loginResponse = new LoginResponse().setToken(jwtToken)
                    .setExpiresIn(jwtService.getExpirationTime());

            return ResponseEntity.ok(loginResponse);
        } catch (BadCredentialsException e) {
            LoginResponse error = new LoginResponse().setError("Sai tài khoản hoặc mật khẩu");
            return ResponseEntity.status(401).body(error);
        }
    }

    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@Valid @RequestBody ChangePasswordDTO changePasswordDto) {
        try {
            authenticationService.changePassword(changePasswordDto.getUsername(),
                    changePasswordDto.getCurrentPassword(), changePasswordDto.getNewPassword());
            return ResponseEntity.ok("Đổi mật khẩu thành công!");
        } catch (BadCredentialsException e) {
            return ResponseEntity.status(401).body("Mật khẩu hiện tại không đúng!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Có lỗi xảy ra khi đổi mật khẩu.");
        }
    }

}
