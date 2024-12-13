package com.web.airplane.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.LoginResponse;
import com.web.airplane.demo.services.JwtService;


import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/auth/admin")
public class AdminAuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;

    public AdminAuthController(AuthenticationManager authenticationManager, JwtService jwtService) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> authenticateAdmin(@Valid @RequestBody LoginDTO loginDto) {
        try {
            Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginDto.getUsername(), loginDto.getPassword())
            );
            log.debug("Authentication: " + authentication);
            

            if (authentication.isAuthenticated()) {
                UserDetails userDetails = (UserDetails) authentication.getPrincipal();
                
                // Check if user has ADMIN role
                if (!userDetails.getAuthorities().stream()
                        .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
                            log.debug("User does not have ADMIN role");
                    return ResponseEntity.status(403)
                        .body(new LoginResponse().setError("Không có quyền truy cập"));
                }

                String token = jwtService.generateToken(userDetails);
                return ResponseEntity.ok(new LoginResponse()
                    .setToken(token)
                    .setExpiresIn(jwtService.getExpirationTime()));
            }

            return ResponseEntity.status(401)
                .body(new LoginResponse().setError("Sai tài khoản hoặc mật khẩu"));

        } catch (BadCredentialsException e) {
        
            return ResponseEntity.status(401)
                .body(new LoginResponse().setError("Sai tài khoản hoặc mật khẩu"));
        }
    }
}
