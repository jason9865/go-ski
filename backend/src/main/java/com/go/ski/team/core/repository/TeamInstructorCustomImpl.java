package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.QPermission;
import com.go.ski.team.core.model.QTeamInstructor;
import com.go.ski.team.support.dto.TeamInstructorResponseDTO;
import com.go.ski.user.core.model.QUser;
import com.querydsl.core.types.Projections;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
public class TeamInstructorCustomImpl implements TeamInstructorCustom{

    private final JPAQueryFactory jpaQueryFactory;
    private final QUser qUser = QUser.user;
    private final QTeamInstructor qTeamInstructor = QTeamInstructor.teamInstructor;
    private final QPermission qPermission = QPermission.permission;


    @Override
    public List<TeamInstructorResponseDTO> findTeamInstructors(Integer teamId) {
        return jpaQueryFactory
                        .select(Projections.fields(
                                TeamInstructorResponseDTO.class,
                                qUser.userId,
                                qUser.userName,
                                qUser.phoneNumber,
                                qUser.profileUrl,
                                qPermission.position
                        ))
                        .from(qUser)
                        .join(qTeamInstructor).on(qTeamInstructor.instructor.user.eq(qUser))
                        .join(qPermission).on(qTeamInstructor.eq(qPermission.teamInstructor))
                        .where(qTeamInstructor.team.teamId.eq(teamId))
                        .fetch();
    }
}
