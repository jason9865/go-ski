package com.go.ski.team.support.dto;

import com.go.ski.team.core.model.TeamInstructor;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class TeamInstructorResponseDTO {

    private Integer userId;
    private String userName;
    private String phoneNumber;
    private String profileUrl;
    private Integer position;

}
