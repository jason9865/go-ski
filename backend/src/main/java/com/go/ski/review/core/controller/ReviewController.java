package com.go.ski.review.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.review.core.service.ReviewService;
import com.go.ski.review.support.dto.TagReviewResponseDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/lesson/review")
public class ReviewController {

    private final ReviewService reviewService;

    @GetMapping("/tags")
    public ResponseEntity<ApiResponse<?>> searchTagReviews() {
        log.info("====ReviewController.searchTagReview====");
        List<TagReviewResponseDTO> response = reviewService.getTagReviews();
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

}
