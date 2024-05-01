package com.go.ski.notification.support;

import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.NotificationType;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
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


}
