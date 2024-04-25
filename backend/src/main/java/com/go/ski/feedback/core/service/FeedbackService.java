package com.go.ski.feedback.core.service;

import com.go.ski.common.constant.FileUploadPath;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.feedback.core.model.FeedbackMedia;
import com.go.ski.feedback.core.repository.FeedbackMediaRepository;
import com.go.ski.feedback.core.repository.FeedbackRepository;
import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackResponseDTO;
import com.go.ski.feedback.support.dto.FeedbackUpdateRequestDTO;
import com.go.ski.feedback.support.exception.FeedbackExceptionEnum;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.repository.LessonRepository;
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
    private final S3Uploader s3Uploader;

    public FeedbackResponseDTO getFeedback(Integer lessonId) {
        Lesson lesson = getLesson(lessonId);

        Feedback feedback = feedbackRepository.findByLesson(lesson)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(FeedbackExceptionEnum.FEEDBACK_NOT_FOUND));
        
        return FeedbackResponseDTO.toDTO(feedback);
    }

    @Transactional
    public void createFeedback(FeedbackCreateRequestDTO request) {

        Lesson lesson = getLesson(request.getLessonId());

        Feedback feedback = Feedback.builder()
                .content(request.getContent())
                .lesson(lesson)
                .build()
                ;

        Feedback savedFeedback = feedbackRepository.save(feedback);

        saveMediaFiles(request,savedFeedback);
    }

    public void updateFeedback(Integer feedbackId, FeedbackUpdateRequestDTO request) {
        Feedback oldfeedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(FeedbackExceptionEnum.FEEDBACK_NOT_FOUND));

        saveMediaFiles(request,oldfeedback);
        deleteMediaFiles(oldfeedback);

        Feedback newFeedback = Feedback.builder()
                .feedbackId(feedbackId)
                .lesson(oldfeedback.getLesson())
                .content(request.getContent())
                .build();

        feedbackRepository.save(newFeedback);
    }

    public Lesson getLesson(Integer lessonId) {
        return lessonRepository.findById(lessonId)
                .orElseThrow(() -> new RuntimeException("해당 강습이 존재하지 않습니다."));
    }

    public void saveMediaFiles(FeedbackRequestDTO request, Feedback feedback) {
        // dto에 분리되어있는 images와 videos 리스트를 하나로 합치기
        List<MultipartFile> mediaFiles = request.getImages();
        mediaFiles.addAll(request.getVideos());

        List<FeedbackMedia> tobeSavedFiles = new ArrayList<>();
        for(MultipartFile file : mediaFiles) {
            String mediaUrl = file.getContentType().split("/")[0].equals("image") ? // content-Type에 따라 다른 경로에 저장
                    s3Uploader.uploadFile(FileUploadPath.FEEDBACK_IMAGE_PATH.path, file) :  // image인 경우
                    s3Uploader.uploadFile(FileUploadPath.FEEDBACK_VIDEO_PATH.path, file); // video인 경우
            tobeSavedFiles.add(FeedbackMedia.builder().mediaUrl(mediaUrl).feedback(feedback).build());
        }

        feedbackMediaRepository.saveAll(tobeSavedFiles);
        log.info("피드백 미디어 파일 업로드 성공 - 파일 개수 : {}개", tobeSavedFiles.size());
    }

    private void deleteMediaFiles(Feedback feedback) {

        List<FeedbackMedia> oldMediaFiles = feedbackRepository.findById(feedback.getFeedbackId())
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(FeedbackExceptionEnum.FEEDBACK_NOT_FOUND))
                .getFeedbackMedia();
        for(FeedbackMedia feedbackMedia : oldMediaFiles) {
            String mediaUrl = feedbackMedia.getMediaUrl();
            if (mediaUrl.split("/")[4].equals("images")) {
                s3Uploader.deleteFile(FileUploadPath.FEEDBACK_IMAGE_PATH.path, mediaUrl);
            } else {
                s3Uploader.deleteFile(FileUploadPath.FEEDBACK_VIDEO_PATH.path, mediaUrl);
            }
        }

        feedbackMediaRepository.deleteAllInBatch(oldMediaFiles);
    }


}
