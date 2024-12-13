package com.web.airplane.demo.services;

import com.web.airplane.demo.models.Image;
import com.web.airplane.demo.repositories.ImageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Base64;

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


    public String getImage(Image image) {
        String base64Image = Base64.getEncoder().encodeToString(image.getImageData());

        // Trả về ảnh dưới dạng base64
        return "data:image/" + image.getType() + ";base64," + base64Image;
    }
}
