package com.go.ski.team.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TeamInstructorResponseDTO {

    private Integer userId;
    private String userName;
    private String phoneNumber;
    private String profileUrl;
    private Integer position;

}
