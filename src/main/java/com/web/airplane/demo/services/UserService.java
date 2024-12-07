package com.web.airplane.demo.services;

import com.web.airplane.demo.dtos.RegisterDTO;
import com.web.airplane.demo.models.Flight;
import com.web.airplane.demo.models.Passenger;
import com.web.airplane.demo.models.Role;
import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.PassengerRepository;
import com.web.airplane.demo.repositories.RoleRepository;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.utils.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository ;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;
    private final PassengerRepository passengerRepository;
    private final JwtService jwtService;


    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder, RoleRepository roleRepository, PassengerRepository passengerRepository, JwtService jwtService) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.roleRepository = roleRepository;
        this.passengerRepository = passengerRepository;
        this.jwtService = jwtService;
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

    public List<Flight> findAllFlight(User user) {
        List<Passenger> passengerList = passengerRepository.findAllByEmail(user.getEmail());
        if (passengerList.isEmpty()) return null;
        List<Flight> flights = new ArrayList<>();
        for (Passenger passenger : passengerList) {
            flights.add(passenger.getFlight());
        }
        return flights;
    }

    public User getCurrentUser(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        String token = authHeader.substring(7);
        String username =  jwtService.extractUsername(token);
        if (username.contains("@")) {
            return userRepository.findByEmail(username);
        }
        return userRepository.findByPhoneNumber(username);
    }
}
