package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.models.Role;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.RoleRepository;
import com.web.airplane.demo.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;

@Service
public class UserService {
    private final UserRepository userRepository ;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;



    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.roleRepository = roleRepository;
    }

    public User createAccount(RegisterDTO registerDTO) {
        User user = new User();

        Role userRole = roleRepository.findById(1L).orElseThrow(() -> new RuntimeException("Role not found"));
        user.setRoles(new HashSet<>(Arrays.asList(userRole)));
        user.setEmail(registerDTO.getEmail());
        user.setBirthdate(registerDTO.getBirthdate());
        user.setLastname(registerDTO.getLastname());
        user.setFirstname(registerDTO.getFirstname());
        user.setPhoneNumber(registerDTO.getPhoneNumber());
        user.setPassword(passwordEncoder.encode(registerDTO.getPassword()));

        return userRepository.save(user);
    }
}
