package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.LoginDTO;
import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.exceptions.AccountAlreadyExistedException;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class AuthenticationService {
    private final UserRepository userRepository;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder passwordEncoder;
    private final UserService userService;

    @Autowired
    public AuthenticationService(
            UserRepository userRepository,
            AuthenticationManager authenticationManager,
            PasswordEncoder passwordEncoder,
            UserService userService) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
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
        log.debug("Bat dau kiem tra");
        // Kiểm tra nếu xác thực thành công
        if (authentication.isAuthenticated()) {
            log.debug("Xac thuc thanh cong");
            if (input.getUsername().contains("@")) {
                return userRepository.findByEmail(input.getUsername());
            } else {
                return userRepository.findByPhoneNumber(input.getUsername());
            }
        }
        log.debug("Sai mat khau");
        throw new BadCredentialsException("Sai tài khoản hoặc mật khẩu.");
    }

    // Method to verify password
    public boolean verifyPassword(String rawPassword, String encodedPassword) {
        return passwordEncoder.matches(rawPassword, encodedPassword);
    }

    // Method to change password
    public void changePassword(HttpServletRequest request, String currentPassword, String newPassword) throws BadCredentialsException {
        User user = userService.getCurrentUser(request);

        log.debug("Lay tai khoan hien tai");
        if (user == null) {
            throw new BadCredentialsException("Mật khẩu hiện tại không đúng!");
        }
        log.debug("Xac nhan");
        LoginDTO loginDTO = new LoginDTO();
        log.debug("current pass" + currentPassword);
        loginDTO.setUsername(user.getUsername());
        loginDTO.setPassword(currentPassword);
        if (authenticate(loginDTO) == null) {
            throw new BadCredentialsException("Mật khẩu hiện tại không đúng!");
        }
        log.debug("Set password");
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }
}
