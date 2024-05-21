package com.go.ski.review.support.dto;

import com.go.ski.review.core.model.TagReview;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class TagReviewResponseDTO {

    private Integer tagReviewId;
    private String tagName;

    public static TagReviewResponseDTO toDTO(TagReview tagReview) {
        TagReviewResponseDTO dto = new TagReviewResponseDTO();
        dto.tagReviewId = tagReview.getTagReviewId();
        dto.tagName = tagReview.getTagName();
        return dto;
    }

}
