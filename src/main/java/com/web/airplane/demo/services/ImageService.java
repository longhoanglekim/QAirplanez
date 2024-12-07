package com.web.airplane.demo.services;

import com.web.airplane.demo.models.Image;
import com.web.airplane.demo.repositories.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;

@Service
public class ImageService {
    @Autowired
    private ImageRepository imageRepository;
    public Image storeImage(MultipartFile file) throws IOException {
        Image image = Image
                .builder()
                .name(file.getOriginalFilename())
                .type(file.getContentType())
                .imageData(file.getBytes())
                .uploadDate(LocalDate.now())
                .build();
        return image;
    }

    public Image getImage(String filename) {
        return imageRepository.findByName(filename);
    }
}
