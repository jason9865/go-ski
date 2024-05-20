package com.go.ski.team.core.model;

import com.go.ski.user.core.model.Instructor;
import jakarta.persistence.*;
import lombok.*;

import static lombok.AccessLevel.PROTECTED;

@Entity
@NoArgsConstructor(access = PROTECTED)
@Getter
@ToString
public class TeamInstructor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer teamInstructorId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "instructor_id")
    private Instructor instructor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "team_id")
    private Team team;

    @Setter
    @Column(nullable = false)
    private boolean isInviteAccepted;

    @Builder
    public TeamInstructor(Integer teamInstructorId, Instructor instructor, Team team, boolean isInviteAccepted){
        this.teamInstructorId = teamInstructorId;
        this.instructor = instructor;
        this.team = team;
        this.isInviteAccepted = isInviteAccepted;
    }

}
