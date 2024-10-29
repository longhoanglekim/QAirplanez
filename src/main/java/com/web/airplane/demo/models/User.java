package com.web.airplane.demo.models;


import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="users")
@Getter
@Setter
public class User {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Long id;

    @Column(nullable=false)
//    @NotBlank(message = "* First Name is required")
    private String fullName;

    @Column(nullable=false, unique=true)
//    @NotBlank(message = "* Username is required")
    private String username;


    @Column(nullable=false)
//    @NotBlank(message = "* Password is required")
    @Size(min=8)
    private String password;

    @Column
    private String phoneNumber;

    @Column
    private String email;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<UserRole> userRoles = new ArrayList<>();


}