package com.go.ski.team.core.model;
import com.go.ski.common.util.TimeConvertor;
import com.go.ski.team.core.service.TeamService;
import com.go.ski.team.support.dto.TeamUpdateRequestDTO;
import com.go.ski.user.core.model.User;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import static com.go.ski.common.util.TimeConvertor.dayoffListToInteger;
import static lombok.AccessLevel.PROTECTED;

@Entity
@NoArgsConstructor(access = PROTECTED)
@Getter
@ToString
public class Team {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY )
    private Integer teamId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "resort_id",nullable = false)
    private SkiResort skiResort;

    @Column(nullable = false)
    private String teamName;

    @Column(nullable = false)
    private String teamProfileUrl;

    private String description;

    @Column(nullable = false)
    private Integer teamCost;

    @Column(nullable = false)
    private Integer dayoff;

    public void updateTeam(TeamUpdateRequestDTO dto, SkiResort skiResort) {
        this.skiResort = skiResort;
        this.teamName = dto.getTeamName();
        this.description = dto.getDescription();
        this.teamCost = dto.getTeamCost();
        this.dayoff = dayoffListToInteger(dto.getDayoff());
    }

    public void updateTeamProfile(String teamProfileUrl) {
        this.teamProfileUrl = teamProfileUrl;
    }

    @Builder
    public Team(Integer teamId, User user, SkiResort skiResort, String teamName,
                String teamProfileUrl, String description, Integer teamCost, Integer dayoff) {
        this.teamId = teamId;
        this.user = user;
        this.skiResort = skiResort;
        this.teamName = teamName;
        this.teamProfileUrl = teamProfileUrl;
        this.description = description;
        this.teamCost = teamCost;
        this.dayoff = dayoff;
    }


}
