package com.web.airplane.demo.models;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "foods")
@Getter
@Setter
@NoArgsConstructor
public class Food {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name; // Tên món ăn

    private String description; // Mô tả món ăn

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "image_id", referencedColumnName = "id") // Khóa ngoại
    private Image image;
}
