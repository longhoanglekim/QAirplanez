package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleJPARepository extends JpaRepository<Role, Long> {
}
