package com.go.ski.lesson.support.dto;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.support.vo.TeamImageVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;

@Getter
@NoArgsConstructor
@ToString
public class ReserveNoviceResponseDTO {
    private Integer teamId;
    private String teamName;
    private String description;
    private Integer teamCost;
    private String teamProfileUrl;
    private List<Integer> instructors;
    private List<TeamImageVO> teamImageVOs;
    private Double rating;

    public ReserveNoviceResponseDTO(Team team, List<Integer> instructors, List<TeamImageVO> teamImageVOs) {
        teamId = team.getTeamId();
        teamName = team.getTeamName();
        description = team.getDescription();
        teamCost = team.getTeamCost();
        teamProfileUrl = team.getTeamProfileUrl();
        this.instructors = instructors;
        this.teamImageVOs = teamImageVOs;
    }
}
