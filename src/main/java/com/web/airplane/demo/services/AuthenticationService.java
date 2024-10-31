package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.exceptions.AccountAlreadyExistedException;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserJPARepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class AuthenticationService {
    private final UserJPARepository userRepository;


    private final UserService userService;

    private final AuthenticationManager authenticationManager;
    @Autowired
    public AuthenticationService(
           UserJPARepository userRepository,
            AuthenticationManager authenticationManager,
            PasswordEncoder passwordEncoder,
            UserService userService) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.userService = userService;
    }

    public User signup(RegisterDTO input) throws AccountAlreadyExistedException {
        // Kiểm tra xem người dùng đã tồn tại hay chưa
        if (userRepository.findByEmail(input.getEmail()) != null && userRepository.findByPhoneNumber(input.getPhoneNumber()) != null) {
            throw new AccountAlreadyExistedException("Account has already existed!");
        }
        return userService.createAccount(input);
    }

    public User authenticate(LoginDTO input) throws BadCredentialsException {
        log.debug("Authenticating user: " + input.getUsername());

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(input.getUsername(), input.getPassword())
        );

        // Kiểm tra nếu xác thực thành công
        if (authentication.isAuthenticated()) {
            if (input.getUsername().contains("@")) {
                return userRepository.findByEmail(input.getUsername());
            } else {
                return userRepository.findByPhoneNumber(input.getUsername());
            }
        }

        throw new BadCredentialsException("Sai tài khoản hoặc mật khẩu.");
    }
}
