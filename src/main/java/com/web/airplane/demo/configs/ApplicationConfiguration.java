package com.web.airplane.demo.configs;

import org.springframework.context.annotation.Primary;
import org.springframework.security.access.expression.SecurityExpressionHandler;
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
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler;

@Configuration
public class ApplicationConfiguration {
    private final UserRepository userRepository;
    private final UserDetailsServiceImpl accountService;

    public ApplicationConfiguration(UserRepository userRepository, UserDetailsServiceImpl accountService) {
        this.userRepository = userRepository;
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
                        "ROLE_ADMIN_FLIGHT > ROLE_ADMIN_FLIGHT_READ\n" +
                        "ROLE_ADMIN_FLIGHT > ROLE_ADMIN_FLIGHT_WRITE\n" +
                        "ROLE_ADMIN_PASSENGER > ROLE_ADMIN_PASSENGER_READ\n" +
                        "ROLE_ADMIN_PASSENGER > ROLE_ADMIN_PASSENGER_WRITE\n" +
                                "ROLE_ADMIN_FLIGHT_READ > ROLE_USER\n" +
                                "ROLE_ADMIN_PASSENGER_READ > ROLE_USER"
        );
    }

}