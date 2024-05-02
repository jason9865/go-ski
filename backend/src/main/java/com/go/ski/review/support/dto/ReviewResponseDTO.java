package com.go.ski.review.support.dto;

import com.go.ski.review.core.model.Review;
import com.go.ski.review.support.vo.InstructorTagsVO;
import lombok.*;

import java.util.List;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
public class ReviewResponseDTO {

    private Integer reviewId;
    private Integer rating;
    private String content;
    List<InstructorTagsVO> instructorTags;

    public static ReviewResponseDTO toDTO(Review review, List<InstructorTagsVO> vos) {
        return ReviewResponseDTO.builder()
                .reviewId(review.getReviewId())
                .rating(review.getRating())
                .content(review.getContents())
                .instructorTags(vos)
                .build();
    }

    public ReviewResponseDTO(Review review) {
        reviewId = review.getReviewId();
        rating = review.getRating();
        content = review.getContents();
    }
}
