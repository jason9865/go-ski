package com.go.ski.review.core.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class TagOnReview {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer tagOnReviewId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "review_id")
    private Review review;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "tag_review_id")
    private TagReview tagReview;

    @Builder
    public TagOnReview(Integer tagOnReviewId, Review review, TagReview tagReview) {
        this.tagOnReviewId = tagOnReviewId;
        this.review = review;
        this.tagReview = tagReview;
    }

}
