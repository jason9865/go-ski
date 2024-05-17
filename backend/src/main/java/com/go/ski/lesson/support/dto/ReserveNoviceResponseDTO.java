package com.go.ski.lesson.support.dto;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.support.vo.TeamImageVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@NoArgsConstructor
@ToString
public class ReserveNoviceResponseDTO extends ReserveResponseDTO {
    private Integer teamId;
    private String teamName;
    private String description;
    private String teamProfileUrl;
    private List<Integer> instructors;
    private List<TeamImageVO> teamImageVOs;

    public ReserveNoviceResponseDTO(Team team, List<Integer> instructors, List<TeamImageVO> teamImageVOs) {
        teamId = team.getTeamId();
        teamName = team.getTeamName();
        description = team.getDescription();
        teamProfileUrl = team.getTeamProfileUrl();
        this.instructors = instructors;
        this.teamImageVOs = teamImageVOs;
    }
}
