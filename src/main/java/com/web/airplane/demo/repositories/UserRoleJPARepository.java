package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRoleJPARepository extends JpaRepository<UserRole, Long> {
}
