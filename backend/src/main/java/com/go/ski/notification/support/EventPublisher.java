package com.go.ski.notification.support;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.user.core.model.Instructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class EventPublisher {

    private final ApplicationEventPublisher applicationEventPublisher;
    private final TeamInstructorRepository teamInstructorRepository;

    public void publish(FcmSendRequestDTO fcmSendRequestDTO, String imageUrl) {
        log.info("알림 보내기 EventPublisher");
        applicationEventPublisher.publishEvent(NotificationEvent.of(fcmSendRequestDTO,imageUrl));
    }

    public void publish(InviteRequestDTO inviteRequestDTO, Team team, Instructor instructor) {
        List<Integer> userIds = teamInstructorRepository.findByTeam(team)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_INSTRUCTOR_NOT_FOUND))
                .stream()
                .map(ti -> ti.getInstructor().getInstructorId())
                .toList();
//        userIds.add(team.getUser().getUserId()); // 사장 Id 추가
        publishEvent(userIds,instructor,inviteRequestDTO);
    }

    private void publishEvent(List<Integer> userIds, Instructor instructor,InviteRequestDTO inviteRequestDTO) {
        userIds.forEach(
            userId -> applicationEventPublisher.publishEvent(
                    NotificationEvent.of(inviteRequestDTO, userId, instructor)
            )
        );
    }


}
