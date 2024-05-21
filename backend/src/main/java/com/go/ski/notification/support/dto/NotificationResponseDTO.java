package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.NotificationType;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NotificationResponseDTO {

    private Integer notificationId;
    private Integer notificationType;
    private LocalDateTime createdAt;
    private byte isRead;
    private String title;
    private String content;
    private String imageUrl;
    private Integer senderId;
    private String senderName;
}
