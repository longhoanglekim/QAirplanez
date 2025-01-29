package com.web.airplane.demo.controllers;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/test")
@Slf4j
public class TestController {
    public TestController() {
      log.debug("Test Controller has been initialized!");
    }

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin")
    public String getAdminMessage() {
        return "Admin hello";
    }

    @GetMapping("/public")
    public String getPublicMessage() {
        return "Everyone hello";
    }
}
