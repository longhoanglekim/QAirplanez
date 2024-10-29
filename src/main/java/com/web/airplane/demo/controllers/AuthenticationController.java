package com.web.airplane.demo.controllers;

import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserJPARepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@Slf4j
public class AuthenticationController {
    private final UserJPARepository userJPARepository;

    public AuthenticationController(UserJPARepository userJPARepository) {
        this.userJPARepository = userJPARepository;
    }
    @PostMapping("/login")
    public ResponseEntity<?> loginAuth(@RequestBody LoginDTO loginDTO) {
        User user = userJPARepository.findByUsernameAndPassword(loginDTO.getUsername(), loginDTO.getPassword());

        if (user != null) {
            return ResponseEntity.ok(user);
        }
        return ResponseEntity.badRequest().build();
    }


}
