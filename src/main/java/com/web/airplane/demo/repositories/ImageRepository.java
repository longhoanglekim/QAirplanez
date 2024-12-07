package com.web.airplane.demo.repositories;

import com.web.airplane.demo.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
    Image findByName(String filename);

}
