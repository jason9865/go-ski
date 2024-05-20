package com.go.ski.review.core.service;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.lesson.support.exception.LessonExceptionEnum;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.review.core.model.Review;
import com.go.ski.review.core.model.TagOnReview;
import com.go.ski.review.core.model.TagReview;
import com.go.ski.review.core.repository.ReviewRepository;
import com.go.ski.review.core.repository.TagOnReviewRepository;
import com.go.ski.review.core.repository.TagReviewRepository;
import com.go.ski.review.support.dto.InstructorReviewResponseDTO;
import com.go.ski.review.support.dto.ReviewCreateRequestDTO;
import com.go.ski.review.support.dto.ReviewResponseDTO;
import com.go.ski.review.support.dto.TagReviewResponseDTO;
import com.go.ski.review.support.exception.ReviewExceptionEnum;
import com.go.ski.review.support.vo.InstructorReviewVO;
import com.go.ski.review.support.vo.InstructorTagsVO;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final TagOnReviewRepository tagOnReviewRepository;
    private final TagReviewRepository tagReviewRepository;
    private final LessonRepository lessonRepository;
    private final InstructorRepository instructorRepository;

    @Transactional(readOnly = true)
    public List<TagReviewResponseDTO> getTagReviews() {
        return tagReviewRepository.findAll()
                .stream()
                .map(TagReviewResponseDTO::toDTO)
                .toList();
    }

    @Transactional
    public void createReview(User user, ReviewCreateRequestDTO request) {
        Lesson lesson = getLesson(request.getLessonId());

        validateWriteReview(lesson,user);

        // 리뷰 저장
        Review review = Review.builder()
                .lesson(lesson)
                .contents(request.getContent())
                .rating(request.getRating())
                .createdAt(LocalDateTime.now())
                .build();

        Review savedReview = reviewRepository.save(review);

        List<TagReview> tagReviewList = tagReviewRepository.findAllById(request.getReviewTags());

        List<TagOnReview> tagOnReviewList = tagReviewList.stream()
                .map(tagReview -> TagOnReview.builder()
                        .tagReview(tagReview)
                        .review(savedReview)
                        .build())
                .toList();

        // 리뷰_리뷰태그 저장
        tagOnReviewRepository.saveAll(tagOnReviewList);
    }

    @Transactional(readOnly = true)
    public List<ReviewResponseDTO> getReviews(Integer lessonId) {
        Lesson lesson = getLesson(lessonId);

        List<Review> reviewList= reviewRepository.findByLesson(lesson);

        List<ReviewResponseDTO> result = new ArrayList<>();
        for (Review review : reviewList) {
            review.updateCreatedAt();
            List<InstructorTagsVO> instructorTags = tagOnReviewRepository.findByReviewId(review.getReviewId());
            result.add(ReviewResponseDTO.toDTO(review,instructorTags));
        }
        return result;
    }

    @Transactional(readOnly = true)
    public List<InstructorReviewResponseDTO> getInstructorReviews(Integer userId) {
        Instructor instructor = instructorRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("해당 강사가 없습니다!")); // 추후 변경 예정

        List<InstructorReviewVO> instructorReviews = reviewRepository.findByInstructor(instructor);

        List<InstructorReviewResponseDTO> result = new ArrayList<>();
        for (InstructorReviewVO reviewVO : instructorReviews) {
            List<InstructorTagsVO> instructorTags = tagOnReviewRepository.findByReviewId(reviewVO.getReviewId());
            result.add(InstructorReviewResponseDTO.toDTO(reviewVO,instructorTags));
        }
        return result;
    }

    private Lesson getLesson(Integer lessonId){
        return  lessonRepository.findById(lessonId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(LessonExceptionEnum.NO_PARAM));
    }

    private void validateWriteReview(Lesson lesson, User user) {
        if(!user.getUserId().equals(lesson.getUser().getUserId())){ // 대표 결제자가 아니면 리뷰 작성 불가
            throw ApiExceptionFactory.fromExceptionEnum(ReviewExceptionEnum.WRONG_REQUEST);
        }
        
        if(reviewRepository.existsByLesson(lesson)){
            throw ApiExceptionFactory.fromExceptionEnum(ReviewExceptionEnum.REVIEW_ALREADY_EXISTS);
        }
        
    }
}
