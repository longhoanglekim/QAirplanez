package com.web.airplane.demo.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "news")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class News {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long newsIndex;
    private String title;
    private LocalDateTime postingDate;
    private LocalDateTime editDate;
    @Column(columnDefinition = "TEXT")
    private String content;

    private String type;

    @OneToOne
    @JoinColumn(name = "image_id", referencedColumnName = "id") // Tạo cột image_id
    private Image image;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author;
}
