package com.web.airplane.demo.dtos.News;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.lang.Long;

@Getter
@Setter
@NoArgsConstructor
public class EditNewsDTO {
    private Long newsId;
    private String content;
}
    