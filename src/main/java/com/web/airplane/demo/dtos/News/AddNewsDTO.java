package com.web.airplane.demo.dtos.News;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@NoArgsConstructor
public class AddNewsDTO {
    private String title;
    private String content;
    private String type;
    private MultipartFile file;
}
    