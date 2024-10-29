package com.web.airplane.demo.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@Table(name = "users_roles", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"role_id", "user_id"})
})
public class UserRole {
    @Id
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;


    public UserRole(User user, Role role) {
        this.role = role;
        this.user = user;
    }
}
