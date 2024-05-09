package com.go.ski.review.core.model;

import com.go.ski.payment.core.model.Lesson;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer reviewId;

    // Lesson Entity 연관관계 매핑해야함
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id", nullable = false)
    private Lesson lesson;

    private String contents;

    private Integer rating;

    private LocalDateTime createdAt;

    public void updateCreatedAt(){
        this.createdAt = LocalDateTime.now();
    }


}
