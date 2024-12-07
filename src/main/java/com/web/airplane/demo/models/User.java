package com.web.airplane.demo.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.*;
import java.util.stream.Collectors;

@Entity
@Table(name="users")
@Getter
@Setter
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String firstname;
    @Column(nullable = false)
    private String lastname;

    @Column(nullable = false)
    private Date birthdate;


    @Column(nullable = false)
    @Size(min = 8)
    private String password;

    @Column
    private String phoneNumber;

    @Column(nullable = false, unique = true)
    private String email;
    private String identification;
    private String nationality;
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Image> avatarList;
    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(name = "user_roles",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"))
    private Set<Role> roles = new HashSet<>();


    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private Set<Passenger> passengers = new HashSet<>();

    @Override
    public String getUsername() {
        return email;
    }

    // Implementing methods of UserDetails interface

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getName()))
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
