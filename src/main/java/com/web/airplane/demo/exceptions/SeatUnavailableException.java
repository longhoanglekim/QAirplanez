package com.web.airplane.demo.exceptions;

public class SeatUnavailableException extends Exception {
    public SeatUnavailableException(String message) {
        super(message);
    }
}
