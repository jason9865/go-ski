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
        Notification notification = new Notification();
        notification.receiverId = notificationEvent.getReceiverId();
        notification.notificationType = notificationEvent.getNotificationType();
        notification.deviceType = notificationEvent.getDeviceType();
        notification.title = notificationEvent.getTitle();
        notification.content = jsonContent;
        notification.createdAt = notificationEvent.getCreatedAt();
        return notification;
    }

    public static Notification of(LessonAlertEvent lessonAlertEvent, String jsonContent) {
        Notification notification = new Notification();
        notification.receiverId = lessonAlertEvent.getReceiverId();
        notification.notificationType = lessonAlertEvent.getNotificationType();
        notification.deviceType = lessonAlertEvent.getDeviceType();
        notification.title = lessonAlertEvent.getTitle();
        notification.content = jsonContent;
        notification.createdAt = lessonAlertEvent.getCreatedAt();
        return notification;
    }

    public static Notification from(MessageEvent messageEvent) {
        Notification notification = new Notification();
        notification.senderId = messageEvent.getSenderId();
        notification.receiverId = messageEvent.getReceiverId();
        notification.notificationType = messageEvent.getNotificationType();
        notification.deviceType = messageEvent.getDeviceType();
        notification.title = messageEvent.getTitle();
        notification.content = messageEvent.getContent();
        notification.imageUrl = messageEvent.getImageUrl();
        notification.createdAt = messageEvent.getCreatedAt();
        return notification;
    }




}
