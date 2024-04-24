package com.go.ski.review.core.repository;


import com.go.ski.payment.core.model.Lesson;
import com.go.ski.review.core.model.Review;
import com.go.ski.review.support.dto.ReviewResponseDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface ReviewRepository extends JpaRepository<Review, Integer> {

    List<Review> findByLesson(Lesson lesson);

}
