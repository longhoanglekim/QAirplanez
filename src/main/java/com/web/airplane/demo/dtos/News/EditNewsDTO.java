package com.web.airplane.demo.dtos.News;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.lang.Long;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class EditNewsDTO {
    private String title;
    private LocalDateTime postingDate;
    private LocalDateTime editDate;
    private String content;
    private String type;
    private MultipartFile file;
    private List<byte[]> imageList;

}
    