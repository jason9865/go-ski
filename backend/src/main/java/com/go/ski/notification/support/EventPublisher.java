package com.go.ski.notification.support;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.support.dto.FcmMessageDTO;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.user.core.model.Instructor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
public class EventPublisher {

    private final ApplicationEventPublisher applicationEventPublisher;
    private final TeamInstructorRepository teamInstructorRepository;

    public void publish(Team team, Instructor instructor) {
        List<Integer> userIds = teamInstructorRepository.findByTeam(team)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_INSTRUCTOR_NOT_FOUND))
                .stream()
                .map(ti -> ti.getInstructor().getInstructorId())
                .toList();
//        userIds.add(team.getUser().getUserId()); // 사장 Id 추가
        publishEvent(userIds,team, instructor);
    }

    private void publishEvent(List<Integer> userIds, Team team, Instructor instructor) {
        userIds.forEach(
            userId -> applicationEventPublisher.publishEvent(
                    InviteRequestDTO.of(userId, team, instructor)
            )
        );
    }


}
