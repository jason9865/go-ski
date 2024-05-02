package com.go.ski.notification.support;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.core.domain.NotificationSetting;
import com.go.ski.notification.core.repository.NotificationSettingRepository;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.notification.support.dto.InviteAcceptRequestDTO;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.relational.core.sql.In;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Slf4j
@Component
@RequiredArgsConstructor
public class EventPublisher {

    private final ApplicationEventPublisher applicationEventPublisher;
    private final TeamInstructorRepository teamInstructorRepository;
    private final NotificationSettingRepository notificationSettingRepository;

    public void publish(FcmSendRequestDTO fcmSendRequestDTO, User user, String imageUrl) {
        log.info("알림 보내기 EventPublisher");
        if (isSendAvailable(fcmSendRequestDTO.getReceiverId(), fcmSendRequestDTO.getNotificationType())){
            applicationEventPublisher.publishEvent(NotificationEvent.of(fcmSendRequestDTO,user.getUserId(), imageUrl));
        }
    }

    public void publish(InviteAcceptRequestDTO inviteAcceptRequestDTO, Team team, Instructor instructor) {
        List<Integer> userIds = new ArrayList<>(teamInstructorRepository.findByTeam(team)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_INSTRUCTOR_NOT_FOUND))
                .stream()
                .map(ti -> ti.getInstructor().getInstructorId())
                .filter(id -> !Objects.equals(id, instructor.getInstructorId()))
                .toList());
        userIds.add(team.getUser().getUserId()); // 사장 Id 추가
        publishEvent(userIds,instructor, inviteAcceptRequestDTO);
    }

    private void publishEvent(List<Integer> userIds, Instructor instructor, InviteAcceptRequestDTO inviteAcceptRequestDTO) {
        userIds.forEach(
            userId -> applicationEventPublisher.publishEvent(
                    NotificationEvent.of(inviteAcceptRequestDTO, userId, instructor)
            )
        );
    }


    public void publish(InviteRequestDTO inviteRequestDTO, Team team) {
        if (isSendAvailable(inviteRequestDTO.getReceiverId(), inviteRequestDTO.getNotificationType())){
            applicationEventPublisher.publishEvent(NotificationEvent.of(inviteRequestDTO, team));
        }
    }

    public boolean isSendAvailable(Integer userId, Integer notificationType) {
        return notificationSettingRepository.findByUserIdAndNotificationType(userId,notificationType)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.NOTIFICATION_SETTING_NOT_FOUND))
                .getNotificationStatus() == 1;
    }

}
