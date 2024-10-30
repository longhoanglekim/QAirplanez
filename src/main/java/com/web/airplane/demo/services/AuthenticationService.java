package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.RegisterDTO;
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

    public User signup(RegisterDTO input) {
        // Kiểm tra xem người dùng đã tồn tại hay chưa
        if (userRepository.findByEmail(input.getEmail()) != null && userRepository.findByPhoneNumber(input.getPhoneNumber()) != null) {
            return null;
        }
        return userService.createAccount(input);
    }

    public User authenticate(LoginDTO input) {
        try {
            log.debug("Authenticating user: " + input.getUsername());
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(input.getUsername(), input.getPassword())
            );
            // Kiểm tra nếu xác thực thành công
            if (authentication.isAuthenticated()) {
                if (input.getUsername().contains("@")) {
                    return userRepository.findByEmail(input.getUsername());
                } else
                    return userRepository.findByPhoneNumber(input.getUsername());
            } else {
                throw new RuntimeException("Unknown authentication error");
            }
        } catch (BadCredentialsException e) {
            // Ném ra lỗi thông tin đăng nhập sai
            throw new RuntimeException("Invalid username or password", e);
        } catch (DisabledException e) {
            // Ném ra lỗi tài khoản bị vô hiệu hóa
            throw new RuntimeException("Account is disabled", e);
        } catch (LockedException e) {
            // Ném ra lỗi tài khoản bị khóa
            throw new RuntimeException("Account is locked", e);
        } catch (AuthenticationException e) {
            // Bắt tất cả các loại lỗi xác thực khác
            throw new RuntimeException("Authentication failed", e);
        } catch (Exception e) {
            // Bắt tất cả các loại lỗi khác
            throw new RuntimeException("Unknown error", e);
        }
    }
}
