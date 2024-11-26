package com.web.airplane.demo.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/test")
public class TestController {
    @PostMapping("/string")
    public ResponseEntity<?> getMessage(@RequestParam("string") String string) {
        return ResponseEntity.ok().body(string);
    }
}
