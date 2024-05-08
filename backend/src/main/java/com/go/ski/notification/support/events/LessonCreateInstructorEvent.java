package com.go.ski.notification.support.events;

import com.go.ski.notification.core.domain.DeviceType;

import java.time.LocalDateTime;

public class LessonCreateInstructorEvent extends NotificationEvent{

    private static final Integer NOTIFICATION_TYPE = 2;

    public LessonCreateInstructorEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title) {
        super(receiverId, createdAt, notificationType, deviceType, title);
    }
}
