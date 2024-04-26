package com.go.ski.feedback.core.repository;

import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.feedback.core.model.FeedbackMedia;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FeedbackMediaRepository extends JpaRepository<FeedbackMedia, Integer> {

    List<FeedbackMedia> findByFeedback(Feedback feedback);

}
