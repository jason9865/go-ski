package com.go.ski.feedback.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.feedback.core.service.FeedbackService;
import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackResponseDTO;
import com.go.ski.feedback.support.dto.FeedbackUpdateRequestDTO;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/lesson/feedback")
public class FeedbackController {

    private final FeedbackService feedbackService;

    @GetMapping("{lessonId}")
    public ResponseEntity<ApiResponse<?>> searchFeedback(@PathVariable Integer lessonId) {
        log.info("FeedbackController.searchFeedback");
        FeedbackResponseDTO response = feedbackService.getFeedback(lessonId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> writeFeedback(HttpServletRequest request,
                                                        FeedbackCreateRequestDTO requestDTO,
                                                        @RequestPart(required = false) List<MultipartFile> images,
                                                        @RequestPart(required = false) List<MultipartFile> videos) {
        log.info("FeedbackController.writeFeedback");
        feedbackService.createFeedback(request, requestDTO, images, videos);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    @PatchMapping("/update/{feedbackId}")
    public ResponseEntity<ApiResponse<?>> updateFeedback(@PathVariable Integer feedbackId,
                                                         FeedbackUpdateRequestDTO requestDTO,
                                                         @RequestPart(required = false) List<MultipartFile> images,
                                                         @RequestPart(required = false) List<MultipartFile> videos) {
        log.info("FeedbackController.updateFeedback");
        feedbackService.updateFeedback(feedbackId, requestDTO,images,videos);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }


}
