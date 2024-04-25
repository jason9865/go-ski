package com.go.ski.feedback.core.model;

import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.payment.core.model.Lesson;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Builder
@AllArgsConstructor
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

    @OneToMany(mappedBy = "FeedbackMedia",cascade = CascadeType.ALL)
    private List<FeedbackMedia> feedbackMedia;


}
