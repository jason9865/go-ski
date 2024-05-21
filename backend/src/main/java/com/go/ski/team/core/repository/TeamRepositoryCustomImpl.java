package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.QLevelOption;
import com.go.ski.team.core.model.QOneToNOption;
import com.go.ski.team.core.model.QTeam;
import com.go.ski.team.support.dto.TeamInfoResponseDTO;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.Optional;

@RequiredArgsConstructor
public class TeamRepositoryCustomImpl implements TeamRepositoryCustom{

    private final JPAQueryFactory jpaQueryFactory;
    private final QTeam qTeam = QTeam.team;
    private final QLevelOption qLevelOption = QLevelOption.levelOption;
    private final QOneToNOption qOneToNOption = QOneToNOption.oneToNOption;



    @Override
    public Optional<TeamInfoResponseDTO> findTeamInfo(Integer teamId) {
        return Optional.ofNullable(
                jpaQueryFactory
                        .select(Projections.fields(
                                TeamInfoResponseDTO.class,
                                qTeam.teamId,
                                qTeam.teamName,
                                qTeam.skiResort.resortId,
                                qTeam.teamProfileUrl.as("teamProfileImageUrl"),
                                qTeam.description,
                                qTeam.teamCost,
                                qTeam.dayoff,
                                qLevelOption.intermediateFee,
                                qLevelOption.advancedFee,
                                qOneToNOption.oneTwoFee,
                                qOneToNOption.oneThreeFee,
                                qOneToNOption.oneFourFee,
                                qOneToNOption.oneNFee
                        ))
                        .from(qTeam)
                        .join(qLevelOption).on(qTeam.teamId.eq(qLevelOption.teamId))
                        .join(qOneToNOption).on(qTeam.teamId.eq(qOneToNOption.teamId))
                        .where(qTeam.teamId.eq(teamId))
                        .fetchOne()
        );
    }

}
