package com.go.ski.team.core.model;

import com.go.ski.team.support.dto.TeamInstructorUpdateRequestDTO;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.springframework.security.core.parameters.P;

@Entity
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class Permission {

    @Id
    private Integer teamInstructorId;

    @MapsId
    @OneToOne
    @JoinColumn(name = "team_instructor_id")
    private TeamInstructor teamInstructor;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Byte invitePermission;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Byte addPermission;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Byte modifyPermission;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Byte deletePermission;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Byte costPermission;

    @Column(nullable = false)
    @ColumnDefault("4")
    private Integer position ;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Integer designatedCost;

    public static Permission createPermission(TeamInstructor teamInstructor, TeamInstructorUpdateRequestDTO requestDTO) {
        return Permission.builder()
                .teamInstructorId(teamInstructor.getTeamInstructorId())
                .teamInstructor(teamInstructor)
                .invitePermission(requestDTO.getInvitePermission())
                .addPermission(requestDTO.getAddPermission())
                .modifyPermission(requestDTO.getModifyPermission())
                .deletePermission(requestDTO.getDeletePermission())
                .costPermission(requestDTO.getCostPermission())
                .position(requestDTO.getPosition())
                .designatedCost(requestDTO.getDesignatedCost())
                .build();
    }
}
