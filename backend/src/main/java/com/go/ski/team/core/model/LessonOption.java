package com.go.ski.team.core.model;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class LessonOption {

    @Id
    private int teamId;

    @MapsId
    @OneToOne
    @JoinColumn(name="team_id")
    private Team team;

    @Column(nullable = false)
    private Integer intermediateFee;

    @Column(nullable = false)
    private Integer advancedFee;

}
