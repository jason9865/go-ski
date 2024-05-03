package com.go.ski.feedback.core.repository;

import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.payment.core.model.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FeedbackRepository extends JpaRepository<Feedback,Integer> {

    Optional<Feedback> findByLesson(Lesson lesson);

    boolean existsByLesson(Lesson lesson);

}
