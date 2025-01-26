package com.web.airplane.demo.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfigurationSource;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

    private final AuthenticationProvider authenticationProvider;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    private final CorsConfigurationSource corsConfigurationSource;

    public SecurityConfiguration(
            JwtAuthenticationFilter jwtAuthenticationFilter,
            AuthenticationProvider authenticationProvider,
            CorsConfigurationSource corsConfigurationSource) {
        this.authenticationProvider = authenticationProvider;
        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
        this.corsConfigurationSource = corsConfigurationSource;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // Disable CSRF protection
                .cors(cors -> cors.configurationSource(corsConfigurationSource)) // Enable CORS
                .exceptionHandling(exceptions -> exceptions.accessDeniedPage("/access-denied"))
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("api/flight/admin/**", "/test/admin/**").hasRole("ADMIN")
                        .requestMatchers("/test/admin_flight/**", "/api/flight/admin_flight/**").hasRole("ADMIN_FLIGHT")
                        .requestMatchers("/test/admin_news/**", "/api/news/admin_news/**").hasRole("ADMIN_NEWS")
                        .requestMatchers("/test/admin_aircraft/**", "/api/flight/admin_aircraft/**").hasRole("ADMIN_AIRCRAFT")
                        .requestMatchers("/api/auth/**","/api/ticket_class/**",
                                "/api/flight/public/**", "/test/string/**", "/api/user/public/**",
                                "/api/airport/public/**", "/favicon.ico", "/api/news/public/**", "/api/meal/public/**").permitAll()

                        .anyRequest().authenticated())
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .authenticationProvider(authenticationProvider)
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class); // Adding JWT filter before the default authentication filter

        return http.build();
    }



}