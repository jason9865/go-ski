package com.go.ski.team.core.model;

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
    private int teamInstructorId;

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


}
