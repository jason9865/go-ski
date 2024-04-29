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
    private NotificationType type;
    private String title;
    private String content;
    private String imageUrl;
    private byte isRead;

//    public static NotificationResponseDTO from (Notification notification) {
//        NotificationResponseDTO dto = new NotificationResponseDTO();
//        dto.notificationId = notification.getNotificationId();
//        dto.senderId = notification.getSenderId();
//        dto.type = notification.getType();
//        dto.title = notification.getTitle();
//        dto.content = notification.getContent();
//        if(notification.getImageUrl() != null){
//            dto.imageUrl = notification.getImageUrl();
//        }
//        dto.isRead = notification.getIsRead();
//        return dto;
//    }

}
