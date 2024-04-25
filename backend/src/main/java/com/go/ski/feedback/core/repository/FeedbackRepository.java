package com.go.ski.feedback.core.repository;

import com.go.ski.feedback.core.model.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FeedbackRepository extends JpaRepository<Feedback,Integer> {
}
