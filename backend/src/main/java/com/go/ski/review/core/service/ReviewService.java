package com.go.ski.review.core.service;

import com.go.ski.review.core.repository.ReviewRepository;
import com.go.ski.review.core.repository.TagOnReviewRepository;
import com.go.ski.review.core.repository.TagReviewRepository;
import com.go.ski.review.support.dto.TagReviewResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final TagOnReviewRepository tagOnReviewRepository;
    private final TagReviewRepository tagReviewRepository;

    public List<TagReviewResponseDTO> getTagReviews() {
        return tagReviewRepository.findAll()
                .stream()
                .map(TagReviewResponseDTO::toDTO)
                .toList();
    }

}
