package com.go.ski.feedback.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString
public class FeedbackCreateRequestDTO {

    private String content;
    private Integer lessonId;

}
