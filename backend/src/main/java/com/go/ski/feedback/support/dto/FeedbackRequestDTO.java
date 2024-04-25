package com.go.ski.feedback.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString
public class FeedbackRequestDTO {

    private String content;
    private List<MultipartFile> images;
    private List<MultipartFile> videos;

}
