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
    private boolean invitePermission;
    private boolean addPermission;
    private boolean modifyPermission;
    private boolean deletePermission;
    private boolean costPermission;
    private Integer position;
    private Integer designatedCost;

}
