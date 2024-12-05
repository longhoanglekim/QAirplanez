package com.web.airplane.demo.utils;

import com.web.airplane.demo.services.JwtService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtUtil {
    private static JwtService jwtService = new JwtService();

    public JwtUtil(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    public static String getToken(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwtToken".equals(cookie.getName())) {
                    log.debug("Found jwtToken cookie in request to URI: " + request.getRequestURI());

                    // Lấy giá trị token từ cookie
                    String token = cookie.getValue();

                    // Kiểm tra xem token có hết hạn chưa
                    if (jwtService.isTokenValid(token)) {
                        log.debug("JWT token has expired.");
                        return null; // Token đã hết hạn, trả về null
                    }

                    return token;
                }
            }
        }
        return null;
    }


    public static void clearJwtTokenCookie(HttpServletResponse response) {
        Cookie newCookie = new Cookie("jwtToken", null);
        newCookie.setMaxAge(0); // Đặt thời gian sống bằng 0 để trình duyệt xóa cookie
        newCookie.setPath("/"); // Đảm bảo cookie được xóa trên toàn bộ domain
        response.addCookie(newCookie);
        log.debug("Cleared jwtToken cookie due to expired or invalid token");
    }

}
