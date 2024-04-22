package com.go.ski.team.core.model;

import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
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

}
