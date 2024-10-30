package com.web.airplane.demo.services;

import com.web.airplane.demo.models.User;
import com.web.airplane.demo.repositories.UserJPARepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    private final UserJPARepository userRepository;

    public UserDetailsServiceImpl(UserJPARepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String input) throws UsernameNotFoundException {
        User account ;
        if (input.contains("@")) {
            account = userRepository.findByEmail(input);
        } else {
            account = userRepository.findByPhoneNumber(input);
        }

        if (account == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return new org.springframework.security.core.userdetails.User(
                account.getUsername(), account.getPassword(), new ArrayList<>());
    }
}