package com.go.ski.team.support.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TeamResponseDTO {

    private Integer teamId;
    private String teamName;
    private String profileUrl;
    private String description;
    private String resortName;

}
