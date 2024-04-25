package com.go.ski.feedback.core.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class FeedbackMedia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer feedbackMediaId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="feedback_id")
    private Feedback feedback;

}
