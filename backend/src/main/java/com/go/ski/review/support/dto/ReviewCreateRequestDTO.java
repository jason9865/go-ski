package com.go.ski.review.support.dto;

import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
public class ReviewCreateRequestDTO {

    private Integer lessonId;
    private Integer rating;
    private String content;
    private List<Integer>  reviewTags;

}
