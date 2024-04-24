package com.go.ski.review.core.repository;

import com.go.ski.review.core.model.Review;
import com.go.ski.review.core.model.TagOnReview;
import com.go.ski.review.core.model.TagReview;
import com.go.ski.review.support.vo.InstructorTagsVO;
import com.querydsl.core.annotations.QueryType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TagOnReviewRepository extends JpaRepository<TagOnReview, Integer> {

    @Query("SELECT new com.go.ski.review.support.vo.InstructorTagsVO(" +
            "tr.tagReviewId, tr.tagName) " +
            "FROM TagOnReview tor " +
            "LEFT OUTER JOIN TagReview tr " +
            "ON tor.tagReview.tagReviewId = tr.tagReviewId " +
            "WHERE tor.review.reviewId = :reviewId")
    List<InstructorTagsVO> findByReviewId(Integer reviewId);

}
