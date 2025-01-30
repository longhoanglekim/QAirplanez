package com.web.airplane.demo.configs;

        import com.web.airplane.demo.services.JwtService;
        import jakarta.servlet.FilterChain;
        import jakarta.servlet.ServletException;
        import jakarta.servlet.http.HttpServletRequest;
        import jakarta.servlet.http.HttpServletResponse;
        import lombok.extern.slf4j.Slf4j;
        import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
        import org.springframework.security.core.context.SecurityContextHolder;
        import org.springframework.security.core.userdetails.UserDetails;
        import org.springframework.security.core.userdetails.UserDetailsService;
        import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
        import org.springframework.stereotype.Component;
        import org.springframework.web.filter.OncePerRequestFilter;
        import java.io.IOException;
        import java.util.Arrays;
        import java.util.List;

@Slf4j
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;

    public JwtAuthenticationFilter(
            JwtService jwtService,
            UserDetailsService userDetailsService
    ) {
        this.jwtService = jwtService;
        this.userDetailsService = userDetailsService;
    }

    /**
     * Todo : Setup that we don't need to use shouldNotFilter
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        String authHeader = request.getHeader("Authorization");
        log.debug(authHeader);
        if (authHeader == null ) {
            filterChain.doFilter(request, response);
            return;
        }

        if (authHeader.contains("Bearer")) {
            authHeader = authHeader.substring(7);
        }
        log.debug("Token being validated: " + authHeader);
        // Nếu token hợp lệ, xác thực và tiếp tục request
        String username = jwtService.extractUsername(authHeader);
        if (username != null && SecurityContextHolder.getContext().getAuthentication() == null) {
            UserDetails userDetails = userDetailsService.loadUserByUsername(username);

            if (jwtService.isTokenValid(authHeader, userDetails)) {
                UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
                        userDetails, null, userDetails.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(auth);
            }
            log.debug("User Authorities: " + userDetails.getAuthorities());
        }

        // Tiếp tục chuỗi filter nếu xác thực thành công
        filterChain.doFilter(request, response);
        log.debug("filter");
    }
}
