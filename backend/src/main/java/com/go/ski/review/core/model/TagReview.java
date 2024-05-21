package com.go.ski.review.core.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class TagReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer tagReviewId;

    private String tagName;

    @Builder
    public TagReview(Integer tagReviewId, String tagName) {
        this.tagReviewId = tagReviewId;
        this.tagName = tagName;
    }


}
