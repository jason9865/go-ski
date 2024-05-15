package com.go.ski.notification.support.events;

import com.go.ski.common.util.TimeConvertor;
import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.redis.dto.PaymentCacheDto;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
public class LessonCreateInstructorEvent extends NotificationEvent{

    private static final Integer NOTIFICATION_TYPE = 2;

    private final Integer lessonId;

    private LessonCreateInstructorEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, Integer lessonId) {
        super(receiverId, createdAt, notificationType, deviceType, title);
        this.lessonId = lessonId;

    }

    public static LessonCreateInstructorEvent of(Lesson lesson, Integer receiverId, String deviceType) {

        return new LessonCreateInstructorEvent(
                receiverId,
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                "강습이 예약되었습니다", // title
                lesson.getLessonId()
        );
    }

}
