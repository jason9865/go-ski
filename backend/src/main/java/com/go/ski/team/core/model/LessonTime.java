package com.go.ski.team.core.model;

import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class LessonTime {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer lessonTimeId;

    @ManyToOne
    @JoinColumn(name="resort_id")
    private SkiResort skiResort;

    @Column(nullable = false)
    private Integer lessonTime;


    @Builder
    public LessonTime(Integer lessonTimeId, SkiResort skiResort, Integer lessonTime) {
        this.lessonTimeId = lessonTimeId;
        this.skiResort = skiResort;
        this.lessonTime = lessonTime;
    }

}
