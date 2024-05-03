package com.go.ski.notification.support;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.feedback.core.model.Feedback;
import com.go.ski.feedback.support.dto.FeedbackRequestDTO;
import com.go.ski.notification.core.repository.NotificationSettingRepository;
import com.go.ski.notification.support.events.MessageEvent;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.notification.support.dto.InviteAcceptRequestDTO;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.notification.support.events.NotificationEvent;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationEventPublisher;
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

    public void publish(FcmSendRequestDTO fcmSendRequestDTO, User user, String imageUrl, String deviceType) {
        log.info("알림 보내기 EventPublisher");
        applicationEventPublisher.publishEvent(MessageEvent.of(fcmSendRequestDTO,user, imageUrl, deviceType));
    }

    public void publish(InviteAcceptRequestDTO inviteAcceptRequestDTO, Team team, Instructor instructor, String deviceType) {
        List<Integer> userIds = new ArrayList<>(teamInstructorRepository.findByTeam(team)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_INSTRUCTOR_NOT_FOUND))
                .stream()
                .map(ti -> ti.getInstructor().getInstructorId())
                .filter(id -> !Objects.equals(id, instructor.getInstructorId()))
                .toList());
        userIds.add(team.getUser().getUserId()); // 사장 Id 추가
        publishEvent(inviteAcceptRequestDTO,userIds, instructor, deviceType);
    }

    private void publishEvent(InviteAcceptRequestDTO inviteAcceptRequestDTO, List<Integer> userIds, Instructor instructor, String deviceType) {
        userIds.forEach(
            userId -> applicationEventPublisher.publishEvent(
                    NotificationEvent.of(inviteAcceptRequestDTO, userId, instructor, deviceType)
            )
        );
    }


    public void publish(InviteRequestDTO inviteRequestDTO, Team team, String deviceType) {
        applicationEventPublisher.publishEvent(NotificationEvent.of(inviteRequestDTO, team, deviceType));

    }


    public void publish(FeedbackRequestDTO feedbackRequestDTO, Lesson lesson, String deviceType) {
        applicationEventPublisher.publishEvent(NotificationEvent.of(feedbackRequestDTO,lesson, deviceType));
    }
}
