package com.web.airplane.demo.models;


import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "images")
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String type;
    private LocalDate uploadDate;
    @Lob
    private byte[] imageData;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
