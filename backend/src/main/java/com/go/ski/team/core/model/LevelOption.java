package com.go.ski.team.core.model;


import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import com.go.ski.team.support.dto.TeamUpdateRequestDTO;
import jakarta.persistence.*;
import lombok.*;

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
    private Team team;

    @Column(nullable = false)
    private Integer intermediateFee;

    @Column(nullable = false)
    private Integer advancedFee;

    public static LevelOption of(Team team, TeamCreateRequestDTO requestDTO) {
        LevelOption levelOption = new LevelOption();
        levelOption.team = team;
        levelOption.intermediateFee = requestDTO.getIntermediateFee();
        levelOption.advancedFee = requestDTO.getAdvancedFee();
        return levelOption;
    }

    public  void update(TeamUpdateRequestDTO requestDTO) {
        this.intermediateFee = requestDTO.getIntermediateFee();
        this.advancedFee = requestDTO.getAdvancedFee();
    }

}
