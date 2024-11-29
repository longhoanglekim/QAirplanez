package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.LoginResponse;
import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.exceptions.AccountAlreadyExistedException;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.AuthenticationService;
import com.web.airplane.demo.services.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@Slf4j
public class AuthenticationController {
    private final UserRepository userRepository;
    private final AuthenticationService authenticationService;
    private final JwtService jwtService;
    @Autowired
    public AuthenticationController(UserRepository userRepository, AuthenticationService authenticationService, JwtService jwtService) {
        this.userRepository = userRepository;
        this.authenticationService = authenticationService;
        this.jwtService = jwtService;
    }
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterDTO registerAccountDto) {
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
    public ResponseEntity<LoginResponse> authenticate(@RequestBody LoginDTO loginUserDto, HttpServletResponse response) {
        try {
            User authenticatedUser = authenticationService.authenticate(loginUserDto);
            String jwtToken = jwtService.generateToken(authenticatedUser);
            Cookie jwtCookie = new Cookie("jwtToken", jwtToken);
            jwtCookie.setHttpOnly(true);
            jwtCookie.setSecure(true);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(60 * 60 * 24);
            response.addCookie(jwtCookie);
            LoginResponse loginResponse = new LoginResponse().setToken(jwtToken).setExpiresIn(jwtService.getExpirationTime());
            return ResponseEntity.ok(loginResponse);
        } catch (BadCredentialsException e) {
            LoginResponse error = new LoginResponse().setError("Sai tài khoản hoặc mật khẩu");
            return ResponseEntity.status(401).body(error);
        }


    }




}
