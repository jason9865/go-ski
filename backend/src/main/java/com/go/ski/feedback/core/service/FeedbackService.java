package com.go.ski.feedback.core.service;

import com.go.ski.common.constant.FileUploadPath;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.feedback.core.model.FeedbackMedia;
import com.go.ski.feedback.core.repository.FeedbackMediaRepository;
import com.go.ski.feedback.core.repository.FeedbackRepository;
import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackResponseDTO;
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

//    public FeedbackResponseDTO getFeedback(Integer lessonId) {
//
//    }

    @Transactional
    public void createFeedback(FeedbackCreateRequestDTO request) {

        Lesson lesson = lessonRepository.findById(request.getLessonId())
                .orElseThrow(() -> new RuntimeException("해당 강습이 존재하지 않습니다."));

        Feedback feedback = Feedback.builder()
                .content(request.getContent())
                .lesson(lesson)
                .build()
                ;

        Feedback savedFeedback = feedbackRepository.save(feedback);

        List<MultipartFile> mediaFiles = request.getImages();
        mediaFiles.addAll(request.getVideos());

        saveMediaFiles(mediaFiles,savedFeedback);

    }

    private void saveMediaFiles(List<MultipartFile> newMediaFiles, Feedback feedback) {
        List<FeedbackMedia> tobeSavedFiles = new ArrayList<>();
        for(MultipartFile file : newMediaFiles) {
            String mediaUrl = s3Uploader.uploadFile(FileUploadPath.FEEDBACK_MEDIA_PATH.path,file);
            tobeSavedFiles.add(FeedbackMedia.builder().mediaUrl(mediaUrl).feedback(feedback).build());
        }

        feedbackMediaRepository.saveAll(tobeSavedFiles);
        log.info("팀 소개 이미지 저장 성공 - 새로 올라온 소개 이미지 개수 : {}장", tobeSavedFiles.size());
    }


}
