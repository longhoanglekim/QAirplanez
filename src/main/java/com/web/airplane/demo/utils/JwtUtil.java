package com.web.airplane.demo.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtUtil {
    public static String getToken(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwtToken".equals(cookie.getName())) {
                    log.debug("Found jwtToken cookie in request to URI: " + request.getRequestURI());
                    return cookie.getValue();
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
