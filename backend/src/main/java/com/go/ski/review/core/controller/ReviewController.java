package com.go.ski.review.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.review.core.service.ReviewService;
import com.go.ski.review.support.dto.InstructorReviewResponseDTO;
import com.go.ski.review.support.dto.ReviewCreateRequestDTO;
import com.go.ski.review.support.dto.ReviewResponseDTO;
import com.go.ski.review.support.dto.TagReviewResponseDTO;
import com.go.ski.user.core.model.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> writeReview(@RequestBody ReviewCreateRequestDTO requestDTO) {
        log.info("====ReviewController.writeReview====");
        reviewService.createReview(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    @GetMapping("/{lessonId}")
    public ResponseEntity<ApiResponse<?>> searchReviews(@PathVariable Integer lessonId) {
        log.info("====ReviewController.searchReviews====");
        List<ReviewResponseDTO> response = reviewService.getReviews(lessonId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/list")
    public ResponseEntity<ApiResponse<?>> searchInstructorReviews(HttpServletRequest request){
        log.info("====ReviewController.searchInstructorReviews====");
        User user = (User) request.getAttribute("user");
        List<InstructorReviewResponseDTO> response = reviewService.getInstructorReviews(user.getUserId());
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/list/{instructorId}")
    public ResponseEntity<ApiResponse<?>> searchInstructorReviewsByInstructorId(@PathVariable Integer instructorId){
        log.info("====ReviewController.searchInstructorReviews====");
        List<InstructorReviewResponseDTO> response = reviewService.getInstructorReviews(instructorId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

}
