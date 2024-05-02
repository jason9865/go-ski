package com.go.ski.team.core.model;

import com.go.ski.team.support.dto.TeamInstructorUpdateRequestDTO;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

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
    private boolean invitePermission;

    @Column(nullable = false)
    private boolean addPermission;

    @Column(nullable = false)
    private boolean modifyPermission;

    @Column(nullable = false)
    private boolean deletePermission;

    @Column(nullable = false)
    private boolean costPermission;

    @Column(nullable = false)
    @ColumnDefault("4")
    private Integer position;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Integer designatedCost;

    public static Permission createPermission(TeamInstructor teamInstructor, TeamInstructorUpdateRequestDTO requestDTO) {
        return Permission.builder()
                .teamInstructorId(teamInstructor.getTeamInstructorId())
                .teamInstructor(teamInstructor)
                .invitePermission(requestDTO.isInvitePermission())
                .addPermission(requestDTO.isAddPermission())
                .modifyPermission(requestDTO.isModifyPermission())
                .deletePermission(requestDTO.isDeletePermission())
                .costPermission(requestDTO.isCostPermission())
                .position(requestDTO.getPosition())
                .designatedCost(requestDTO.getDesignatedCost())
                .build();
    }
}
