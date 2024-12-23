package com.web.airplane.demo.dtos.News;

import com.web.airplane.demo.models.Image;
import com.web.airplane.demo.models.User;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
public class NewsResponse {
    private Long index;
    private String title;
    private LocalDateTime postingDate;
    private LocalDateTime editDate;
    private String content;
    private String type;
    private String imageData;

    private List<byte[]> imageList;

    private String author;

    public String getFormattedPostingDate() {
        return "Ngày " + postingDate.getDayOfMonth() + " tháng " + postingDate.getMonth().getValue() + " năm " +
                postingDate.getYear();
    }
}
