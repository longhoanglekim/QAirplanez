package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByPhoneNumber(String p);
    User findByEmail(String email);
}