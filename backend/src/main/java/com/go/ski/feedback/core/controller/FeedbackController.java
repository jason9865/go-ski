package com.go.ski.feedback.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.feedback.core.service.FeedbackService;
import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackResponseDTO;
import com.go.ski.feedback.support.dto.FeedbackUpdateRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/feedback")
public class FeedbackController {

    private final FeedbackService feedbackService;

    @GetMapping("{lessonId}")
    public ResponseEntity<ApiResponse<?>> searchFeedback(@PathVariable Integer lessonId) {
        log.info("FeedbackController.searchFeedback");
        FeedbackResponseDTO response = feedbackService.getFeedback(lessonId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> writeFeedback(FeedbackCreateRequestDTO requestDTO) {
        log.info("FeedbackController.writeFeedback");
        feedbackService.createFeedback(requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    @PatchMapping("/update/{feedbackId}")
    public ResponseEntity<ApiResponse<?>> updateFeedback(@PathVariable Integer feedbackId, FeedbackUpdateRequestDTO requestDTO) {
        log.info("FeedbackController.updateFeedback");
        feedbackService.updateFeedback(feedbackId, requestDTO);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }


}
