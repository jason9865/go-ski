package com.go.ski.Notification.support.dto;

import com.go.ski.Notification.core.domain.Notification;
import com.go.ski.Notification.core.domain.NotificationType;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

@Getter
@NoArgsConstructor
public class NotificationResponseDTO {

    private Integer notifcationId;
    private NotificationType type;
    private String title;
    private String content;
    private String imageUrl;
    private byte isRead;

    public static NotificationResponseDTO from (Notification notification) {
        NotificationResponseDTO dto = new NotificationResponseDTO();
        dto.notifcationId = notification.getNotificationId();
        dto.type = notification.getType();
        dto.title = notification.getTitle();
        dto.content = notification.getContent();
        if(notification.getImageUrl() != null){
            dto.imageUrl = notification.getImageUrl();
        }
        dto.isRead = notification.getIsRead();
        return dto;
    }

}
