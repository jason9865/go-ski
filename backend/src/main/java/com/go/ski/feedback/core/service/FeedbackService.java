package com.go.ski.feedback.core.service;

import com.go.ski.common.constant.FileUploadPath;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.feedback.core.model.FeedbackMedia;
import com.go.ski.feedback.core.repository.FeedbackMediaRepository;
import com.go.ski.feedback.core.repository.FeedbackRepository;
import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackResponseDTO;
import com.go.ski.feedback.support.dto.FeedbackUpdateRequestDTO;
import com.go.ski.feedback.support.exception.FeedbackExceptionEnum;
import com.go.ski.lesson.support.exception.LessonExceptionEnum;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.repository.LessonRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final FeedbackMediaRepository feedbackMediaRepository;
    private final LessonRepository lessonRepository;
    private final EventPublisher eventPublisher;
    private final S3Uploader s3Uploader;

    public FeedbackResponseDTO getFeedback(Integer lessonId) {
        Lesson lesson = getLesson(lessonId);

        Feedback feedback = feedbackRepository.findByLesson(lesson)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(FeedbackExceptionEnum.FEEDBACK_NOT_FOUND));
        
        return FeedbackResponseDTO.toDTO(feedback);
    }

    @Transactional
    public void createFeedback(HttpServletRequest request, FeedbackCreateRequestDTO feedbackCreateRequestDTO,
                               List<MultipartFile> images, List<MultipartFile> videos) {
        String deviceType = request.getHeader("DeviceType");

        Lesson lesson = getLesson(feedbackCreateRequestDTO.getLessonId());

        validateAlreadyExist(lesson);

        Feedback feedback = Feedback.builder()
                .content(feedbackCreateRequestDTO.getContent())
                .lesson(lesson)
                .build()
                ;
        
        Feedback savedFeedback = feedbackRepository.save(feedback);
        saveMediaFiles(images,videos,savedFeedback);
        eventPublisher.publish(feedbackCreateRequestDTO,lesson, deviceType);
    }

    @Transactional
    public void updateFeedback(Integer feedbackId, FeedbackUpdateRequestDTO request,
                               List<MultipartFile> images, List<MultipartFile> videos) {
        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(FeedbackExceptionEnum.FEEDBACK_NOT_FOUND));

        List<FeedbackMedia> oldMediaFiles = feedbackMediaRepository.findByFeedback(feedback);

        feedback.updateContent(request);

        saveMediaFiles(images, videos, feedback);
        deleteMediaFiles(oldMediaFiles);

        feedbackRepository.save(feedback);
    }

    public Lesson getLesson(Integer lessonId) {
        return lessonRepository.findById(lessonId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(LessonExceptionEnum.WRONG_REQUEST));
    }

    private void saveMediaFiles(List<MultipartFile> imageFiles, List<MultipartFile> videoFiles, Feedback feedback) {
        // 기회가 된다면 media를 저장하는 로직은 별도로 분리하자

        List<FeedbackMedia> tobeSavedFiles = new ArrayList<>();

        if (imageFiles != null) {
            for (MultipartFile file : imageFiles) {
                String imageUrl = s3Uploader.uploadFile(FileUploadPath.FEEDBACK_IMAGE_PATH.path, file);
                tobeSavedFiles.add(FeedbackMedia.builder().mediaUrl(imageUrl).feedback(feedback).build());
            }
        }

        if (videoFiles != null) {
            for (MultipartFile file : videoFiles) {
                String videoUrl = s3Uploader.uploadFile(FileUploadPath.FEEDBACK_IMAGE_PATH.path, file);
                tobeSavedFiles.add(FeedbackMedia.builder().mediaUrl(videoUrl).feedback(feedback).build());
            }
        }

        feedbackMediaRepository.saveAll(tobeSavedFiles);
        log.info("피드백 미디어 파일 업로드 성공 - 파일 개수 : {}개", tobeSavedFiles.size());
    }

    private void deleteMediaFiles(List<FeedbackMedia> oldMediaFiles) {

        for(FeedbackMedia feedbackMedia : oldMediaFiles) {
            String mediaUrl = feedbackMedia.getMediaUrl();
            if (mediaUrl.split("/")[4].equals("images")) {
                s3Uploader.deleteFile(mediaUrl);
            } else {
                s3Uploader.deleteFile(mediaUrl);
            }
        }

        feedbackMediaRepository.deleteAllInBatch(oldMediaFiles);
    }

    private void validateAlreadyExist(Lesson lesson) {
        if (feedbackRepository.existsByLesson(lesson)){
            throw ApiExceptionFactory.fromExceptionEnum(FeedbackExceptionEnum.FEEDBACK_ALREADY_EXIST);
        }
    }


}
