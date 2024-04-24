package com.go.ski.team.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@Getter
@Setter
@ToString
public class TeamInstructorUpdateRequestDTO {

    private Integer teamId;
    private Integer instructorId;
    private Byte invitePermission;
    private Byte addPermission;
    private Byte modifyPermission;
    private Byte deletePermission;
    private Byte costPermission;
    private Integer position;
    private Integer designatedCost;

}
