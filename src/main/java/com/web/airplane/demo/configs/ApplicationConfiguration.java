package com.web.airplane.demo.configs;

import org.springframework.security.authentication.AuthenticationProvider;
import com.web.airplane.demo.repositories.UserJPARepository;
import com.web.airplane.demo.services.UserDetailsServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class ApplicationConfiguration {
    private final UserJPARepository userRepository;
    private final UserDetailsServiceImpl accountService;

    public ApplicationConfiguration(UserJPARepository userRepository, UserDetailsServiceImpl accountService) {
        this.userRepository = userRepository;
        this.accountService = accountService;
    }

    @Bean
    UserDetailsService userDetailsService() {
        if (userRepository == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return userRepository::findByUsername;
    }

    @Bean
    BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        authProvider.setUserDetailsService(userDetailsService());
        authProvider.setPasswordEncoder(passwordEncoder());

        return authProvider;
    }
}