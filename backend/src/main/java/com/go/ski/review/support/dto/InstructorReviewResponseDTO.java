package com.go.ski.review.support.dto;

import com.go.ski.review.support.vo.InstructorReviewVO;
import com.go.ski.review.support.vo.InstructorTagsVO;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class InstructorReviewResponseDTO {

    private InstructorReviewVO instructorReview;
    private List<InstructorTagsVO> instructorTags;

}
