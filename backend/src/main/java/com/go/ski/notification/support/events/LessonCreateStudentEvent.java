package com.go.ski.notification.support.events;

import com.go.ski.common.util.TimeConvertor;
import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.payment.core.model.LessonInfo;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
public class LessonCreateStudentEvent extends NotificationEvent{

    private static final Integer NOTIFICATION_TYPE = 7;

    private final String detail;
    private final String lessonDate;
    private final String lessonTime;
    private final String resortName;
    private final String studentCount;
    private final String lessonType;


    private LessonCreateStudentEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, String detail, String lessonDate,
            String lessonTime, String resortName,
            String studentCount, String lessonType) {
        super(receiverId, createdAt, notificationType, deviceType,title);
        this.detail = detail;
        this.lessonDate = lessonDate;
        this.lessonTime = lessonTime;
        this.resortName = resortName;
        this.studentCount = studentCount;
        this.lessonType = lessonType;
    }

    public static LessonCreateStudentEvent of(LessonInfo lessonInfo, String resortName,
                                              Integer receiverId, String deviceType) {

        LocalDate lessonDate = lessonInfo.getLessonDate();
        String month = lessonDate.getMonth().getValue() + "월";
        String day = lessonDate.getDayOfMonth() + "일";
        String startTime = TimeConvertor.calNewStartTime(lessonInfo.getStartTime());
        String hour = startTime.split(":")[0] + "시";
        String minute = startTime.split(":")[1] + "분";
        String lessonOneToN = "1:" + lessonInfo.getStudentCount();
        String lessonType = TimeConvertor.convertFromBitmask(lessonInfo.getLessonType());

        String detail = month + " " + day + " " + hour + " " + minute + " " + resortName + "\n" + lessonOneToN
                + " 강습이 예약되었습니다";

        return new LessonCreateStudentEvent(
                receiverId,
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                "강습이 예약되었습니다",
                detail,
                lessonInfo.getLessonDate().toString(),
                TimeConvertor.calLessonTimeInfo(lessonInfo.getStartTime(), lessonInfo.getDuration()),
                resortName,
                lessonInfo.getStudentCount().toString(),
                lessonType
        );
    }

}
