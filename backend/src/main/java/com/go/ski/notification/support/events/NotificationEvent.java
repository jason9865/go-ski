package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.support.dto.InviteAcceptRequestDTO;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.Instructor;
import lombok.*;

import java.time.LocalDateTime;


@Getter
@RequiredArgsConstructor
@ToString
public class NotificationEvent {

    private Integer receiverId;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private Integer notificationType;
    private DeviceType deviceType;


    public static NotificationEvent of(InviteAcceptRequestDTO requestDTO, Integer userId, Instructor instructor) {
        NotificationEvent notificationEvent = new NotificationEvent();
        notificationEvent.receiverId = userId;
        notificationEvent.title = instructor.getUser().getUserName() + " 강사가 팀에 초대되었습니다";
        notificationEvent.createdAt = LocalDateTime.now();
        notificationEvent.notificationType = requestDTO.getNotificationType();
        notificationEvent.deviceType = requestDTO.getDeviceType();
        return notificationEvent;
    }

    public static Object of(InviteRequestDTO inviteRequestDTO, Team team) {
        NotificationEvent notificationEvent = new NotificationEvent();
        notificationEvent.receiverId = inviteRequestDTO.getReceiverId();
        notificationEvent.title = team.getTeamName() + "에서 팀 초대 요청이 왔습니다.";
        notificationEvent.content = team.getTeamId().toString();
        notificationEvent.createdAt = LocalDateTime.now();
        notificationEvent.notificationType = inviteRequestDTO.getNotificationType();
        notificationEvent.deviceType = inviteRequestDTO.getDeviceType();
        return notificationEvent;
    }
}
