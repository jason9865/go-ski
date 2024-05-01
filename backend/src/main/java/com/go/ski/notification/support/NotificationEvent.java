package com.go.ski.notification.support;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.NotificationType;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
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
    private NotificationType notificationType;
    private DeviceType deviceType;
    private String imageUrl;


    public static  NotificationEvent of(FcmSendRequestDTO requestDTO, String imageUrl) {
        NotificationEvent notificationEvent = new NotificationEvent();
        notificationEvent.receiverId = requestDTO.getReceiverId();
        notificationEvent.title = requestDTO.getTitle();
        notificationEvent.content = requestDTO.getContent();
        notificationEvent.createdAt = LocalDateTime.now();
        notificationEvent.notificationType = requestDTO.getNotificationType();
        notificationEvent.deviceType = requestDTO.getDeviceType();
        notificationEvent.imageUrl = imageUrl;
        return notificationEvent;
    }


    public static NotificationEvent of(InviteRequestDTO requestDTO, Integer userId, Instructor instructor) {
        NotificationEvent notificationEvent = new NotificationEvent();
        notificationEvent.receiverId = userId;
        notificationEvent.title = instructor.getUser().getUserName() + "강사가 팀에 초대되었습니다";
        notificationEvent.createdAt = LocalDateTime.now();
        notificationEvent.notificationType = requestDTO.getNotificationType();
        notificationEvent.deviceType = requestDTO.getDeviceType();
        return notificationEvent;
    }
}
