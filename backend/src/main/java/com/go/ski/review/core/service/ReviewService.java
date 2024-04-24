package com.go.ski.review.core.service;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.repository.LessonRepository;
import com.go.ski.review.core.model.Review;
import com.go.ski.review.core.model.TagOnReview;
import com.go.ski.review.core.model.TagReview;
import com.go.ski.review.core.repository.ReviewRepository;
import com.go.ski.review.core.repository.TagOnReviewRepository;
import com.go.ski.review.core.repository.TagReviewRepository;
import com.go.ski.review.support.dto.ReviewCreateRequestDTO;
import com.go.ski.review.support.dto.ReviewResponseDTO;
import com.go.ski.review.support.dto.TagReviewResponseDTO;
import com.go.ski.review.support.vo.InstructorTagsVO;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final TagOnReviewRepository tagOnReviewRepository;
    private final TagReviewRepository tagReviewRepository;
    private final LessonRepository lessonRepository;

    public List<TagReviewResponseDTO> getTagReviews() {
        return tagReviewRepository.findAll()
                .stream()
                .map(TagReviewResponseDTO::toDTO)
                .toList();
    }

    @Transactional
    public void createReview(ReviewCreateRequestDTO request) {
        Lesson lesson = lessonRepository.findById(request.getLessonId())
                .orElseThrow(() -> new RuntimeException("해당 강습이 존재하지 않습니다!")); // 추후 변경 예정

        // 리뷰 저장
        Review review = Review.builder()
                .lesson(lesson)
                .contents(request.getContent())
                .rating(request.getRating())
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

    public List<ReviewResponseDTO> getReview(Integer lessonId) {
        Lesson lesson = lessonRepository.findById(lessonId)
                .orElseThrow(() -> new RuntimeException("해당 강습이 존재하지 않습니다!"));

        List<Review> reviewList= reviewRepository.findByLesson(lesson);

        List<ReviewResponseDTO> result = new ArrayList<>();
        for (Review review : reviewList) {
            List<InstructorTagsVO> instructorTags = tagOnReviewRepository.findByReview(review);
            result.add(ReviewResponseDTO.toDTO(review,instructorTags));
        }
        return result;
    }
}
