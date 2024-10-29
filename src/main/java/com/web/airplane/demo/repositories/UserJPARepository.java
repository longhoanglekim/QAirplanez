package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserJPARepository extends JpaRepository<User, Long> {
    User findByUsernameAndPassword(String username, String password);
}
