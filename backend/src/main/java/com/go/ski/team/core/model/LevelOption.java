package com.go.ski.team.core.model;


import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import com.go.ski.team.support.dto.TeamUpdateRequestDTO;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.util.logging.Level;

@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Getter
@ToString
public class LevelOption {

    @Id
    private Integer teamId;

    @MapsId
    @OneToOne
    @JoinColumn(name="team_id")
    @OnDelete(action = OnDeleteAction.CASCADE)
    private Team team;

    @Column(nullable = false)
    private Integer intermediateFee;

    @Column(nullable = false)
    private Integer advancedFee;

    public static LevelOption createLevelOption(Team team, TeamCreateRequestDTO requestDTO) {
        LevelOption levelOption = new LevelOption();
        levelOption.team = team;
        levelOption.intermediateFee = requestDTO.getIntermediateFee();
        levelOption.advancedFee = requestDTO.getAdvancedFee();
        return levelOption;
    }

    public static LevelOption createLevelOption(Team team, TeamUpdateRequestDTO requestDTO) {
        LevelOption levelOption = new LevelOption();
        levelOption.teamId = team.getTeamId();
        levelOption.team = team;
        levelOption.intermediateFee = requestDTO.getIntermediateFee();
        levelOption.advancedFee = requestDTO.getAdvancedFee();
        return levelOption;
    }

}
