package com.go.ski.notification.support.events;

import com.go.ski.common.util.TimeConvertor;
import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.payment.core.model.LessonInfo;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class LessonCreateEvent extends NotificationEvent{

    private static final Integer NOTIFICATION_TYPE = 2;
    private static final String TITLE_COMMENT = "강습이 예약되었습니다";

    private final String lessonDate;
    private final String lessonTime;


    private LessonCreateEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, String lessonDate,
            String lessonTime) {
        super(receiverId, createdAt, notificationType, deviceType,title);
        this.lessonDate = lessonDate;
        this.lessonTime = lessonTime;
    }

    public static LessonCreateEvent of(LessonInfo lessonInfo, Integer receiverId, String deviceType) {
        return new LessonCreateEvent(
                receiverId,
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                "강습이 예약되었습니다",
                lessonInfo.getLessonDate().toString(),
                TimeConvertor.calLessonTimeInfo(lessonInfo.getStartTime(), lessonInfo.getDuration())
        );
    }

}
