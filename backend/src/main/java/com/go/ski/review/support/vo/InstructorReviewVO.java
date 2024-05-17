package com.go.ski.review.support.vo;

import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class InstructorReviewVO {

    private Integer reviewId;
    private Integer lessonId;
    private LocalDate lessonDate;
    private String startTime;
    private Integer duration;
    private String representativeName;
    private Integer rating;
    private String content;
    private LocalDateTime createdAt;

}
