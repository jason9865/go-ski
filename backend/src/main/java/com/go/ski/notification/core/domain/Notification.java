package com.go.ski.notification.core.domain;

import com.go.ski.notification.support.events.LessonAlertEvent;
import com.go.ski.notification.support.events.MessageEvent;
import com.go.ski.notification.support.events.NotificationEvent;
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

    public void read(){
        isRead = 1;
    }

    public static Notification of(NotificationEvent notificationEvent, String jsonContent) {
        return Notification.builder()
                .receiverId(notificationEvent.getReceiverId())
                .notificationType(notificationEvent.getNotificationType())
                .deviceType(notificationEvent.getDeviceType())
                .title(notificationEvent.getTitle())
                .content(jsonContent)
                .createdAt(notificationEvent.getCreatedAt())
                .build();
    }

    public static Notification of(LessonAlertEvent lessonAlertEvent, String jsonContent) {
        return Notification.builder()
                .receiverId(lessonAlertEvent.getReceiverId())
                .notificationType(lessonAlertEvent.getNotificationType())
                .deviceType(lessonAlertEvent.getDeviceType())
                .title(lessonAlertEvent.getTitle())
                .content(jsonContent)
                .createdAt(lessonAlertEvent.getCreatedAt())
                .build();
    }

    public static Notification from(MessageEvent messageEvent) {
        return Notification.builder()
                .senderId(messageEvent.getSenderId())
                .receiverId(messageEvent.getReceiverId())
                .notificationType(messageEvent.getNotificationType())
                .deviceType(messageEvent.getDeviceType())
                .title(messageEvent.getTitle())
                .content(messageEvent.getContent())
                .imageUrl(messageEvent.getImageUrl())
                .createdAt(messageEvent.getCreatedAt())
                .build();
    }




}
