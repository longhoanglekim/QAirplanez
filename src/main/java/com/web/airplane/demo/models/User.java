package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name="users")
@Getter
@Setter
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(nullable = false)
    private String fullName;

    @Column(nullable = false, unique = true)
    private String username;

    @Column(nullable = false)
    @Size(min = 8)
    private String password;

    @Column
    private String phoneNumber;

    @Column
    private String email;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<UserRole> userRoles = new ArrayList<>();

    // Implementing methods of UserDetails interface

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return userRoles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getRole().getName()))
                .collect(Collectors.toList());
    }

    @Override
    public boolean isAccountNonExpired() {
        return true; // Customize this if you want to add account expiration logic
    }

    @Override
    public boolean isAccountNonLocked() {
        return true; // Customize this if you want to add account locking logic
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true; // Customize this if you want to add credentials expiration logic
    }

    @Override
    public boolean isEnabled() {
        return true; // Customize this if you want to add account enabling/disabling logic
    }
}
