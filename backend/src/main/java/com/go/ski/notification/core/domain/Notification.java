package com.go.ski.notification.core.domain;

import com.go.ski.notification.support.NotificationEvent;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import java.time.LocalDateTime;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder
@ToString
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer notificationId;

    @Column(nullable = false)
    private Integer receiverId;

    private Integer senderId;

    @Column(nullable = false)
    private Integer notificationType;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private DeviceType deviceType;

    @Column(nullable = false)
    private String title;

    private String content;

    private String imageUrl;

    @ColumnDefault("0")
    private byte isRead;

    private LocalDateTime createdAt;

    public static Notification from(NotificationEvent notificationEvent) {
        return Notification.builder()
                .receiverId(notificationEvent.getReceiverId())
                .notificationType(notificationEvent.getNotificationType())
                .deviceType(notificationEvent.getDeviceType())
                .title(notificationEvent.getTitle())
                .content(notificationEvent.getContent())
                .createdAt(notificationEvent.getCreatedAt())
                .build();
    }

    public void read(){
        isRead = 1;
    }

}
