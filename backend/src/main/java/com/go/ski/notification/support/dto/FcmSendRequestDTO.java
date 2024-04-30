package com.go.ski.notification.support.dto;

import com.go.ski.notification.core.domain.NotificationType;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FcmSendRequestDTO {
    private Integer senderId;
    private Integer receiverId;
    private String title;
    private String content;
    private MultipartFile image;
    private String deviceType;
    private NotificationType notificationType;
}
