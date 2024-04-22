package com.go.ski.team.core.model;

import com.go.ski.user.core.model.Instructor;
import jakarta.persistence.*;
import lombok.*;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
@Getter
@ToString
public class TeamInstructor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int teamInstructorId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private Instructor instructor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id")
    private Team team;

    @Setter
    @Column(nullable = false)
    private boolean isInviteAccepted;

}
