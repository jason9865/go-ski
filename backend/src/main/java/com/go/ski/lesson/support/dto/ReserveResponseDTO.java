package com.go.ski.lesson.support.dto;

import com.go.ski.review.core.model.Review;
import com.go.ski.review.support.dto.ReviewResponseDTO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveResponseDTO {
    private Integer cost;
    private Double rating;
    private Integer reviewCount;
    private List<ReviewResponseDTO> reviews;
}
