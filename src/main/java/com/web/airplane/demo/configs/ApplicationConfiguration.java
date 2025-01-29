package com.web.airplane.demo.configs;


import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.authentication.AuthenticationProvider;
import com.web.airplane.demo.repositories.UserRepository;
import com.web.airplane.demo.services.UserDetailsServiceImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
public class ApplicationConfiguration {

    private final UserDetailsServiceImpl accountService;

    public ApplicationConfiguration(UserDetailsServiceImpl accountService) {
        this.accountService = accountService;
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

        authProvider.setUserDetailsService(accountService);
        authProvider.setPasswordEncoder(passwordEncoder());

        return authProvider;
    }
    @Bean
    public RoleHierarchy roleHierarchy() {
        // Sử dụng phương thức fromHierarchy để tạo RoleHierarchy từ chuỗi
        return RoleHierarchyImpl.fromHierarchy(
                        "ROLE_ADMIN > ROLE_ADMIN_FLIGHT\n" +
                        "ROLE_ADMIN > ROLE_ADMIN_PASSENGER\n" +
                        "ROLE_ADMIN > ROLE_ADMIN_NEWS\n" +
                        "ROLE_ADMIN > ROLE_ADMIN_AIRCRAFT\n" +
                        "ROLE_ADMIN_FLIGHT > ROLE_ADMIN_FLIGHT_READ\n" +
                        "ROLE_ADMIN_FLIGHT > ROLE_ADMIN_FLIGHT_WRITE\n" +
                        "ROLE_ADMIN_PASSENGER > ROLE_ADMIN_PASSENGER_READ\n" +
                        "ROLE_ADMIN_PASSENGER > ROLE_ADMIN_PASSENGER_WRITE\n" +
                                "ROLE_ADMIN_FLIGHT_READ > ROLE_USER\n" +
                                "ROLE_ADMIN_PASSENGER_READ > ROLE_USER"
        );
    }
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(List.of("http://localhost:8080", "http://localhost:3000"));
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE"));
        configuration.setAllowedHeaders(List.of("Authorization", "Content-Type"));
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        configuration.setAllowCredentials(true);
        return source;
    }
}