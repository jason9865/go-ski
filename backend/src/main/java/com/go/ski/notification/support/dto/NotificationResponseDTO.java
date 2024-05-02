package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.NotificationType;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NotificationResponseDTO {

    private Integer notificationId;
    private Integer senderId;
    private String senderName;
    private NotificationType notificationType;
    private String title;
    private String content;
    private String imageUrl;
    private byte isRead;

}
