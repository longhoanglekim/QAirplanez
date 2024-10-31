package com.web.airplane.demo.exceptions;

public class AccountAlreadyExistedException extends Exception {
    public AccountAlreadyExistedException(String message) {
        super(message);
    }
}
