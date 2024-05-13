package com.go.ski.feedback.core.model;

import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.feedback.support.dto.FeedbackUpdateRequestDTO;
import com.go.ski.payment.core.model.Lesson;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class Feedback {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer feedbackId;

    @OneToOne
    @JoinColumn(name="lesson_id")
    private Lesson lesson;

    private String content;

    @OneToMany(mappedBy = "feedback",cascade = CascadeType.ALL)
    private List<FeedbackMedia> feedbackMedia;

    public void updateContent(FeedbackUpdateRequestDTO dto) {
        this.content = dto.getContent();
    }

    @Builder
    public Feedback(Lesson lesson, String content, List<FeedbackMedia> feedbackMedia){
        this.lesson = lesson;
        this.content = content;
        this.feedbackMedia = feedbackMedia;
    }
}
