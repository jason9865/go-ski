package com.go.ski.notification.support.events;

import com.go.ski.common.util.TimeConvertor;
import com.go.ski.notification.core.domain.DeviceType;
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

    private final String lessonDate;
    private final String lessonTime;
    private final String resortName;
    private final String studentCount;
    private final String lessonType;
    private final List<StudentInfoDTO> studentInfos;

    public LessonCreateInstructorEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, String lessonDate,
            String lessonTime, String resortName,
            String studentCount, String lessonType,
            List<StudentInfoDTO> studentInfos) {
        super(receiverId, createdAt, notificationType, deviceType, title);
        this.lessonDate = lessonDate;
        this.lessonTime = lessonTime;
        this.resortName = resortName;
        this.studentCount = studentCount;
        this.lessonType = lessonType;
        this.studentInfos = studentInfos;

    }

    public static LessonCreateInstructorEvent of(LessonInfo lessonInfo, String resortName,
                  Integer receiverId, PaymentCacheDto paymentCacheDto, String deviceType) {

        String month = lessonInfo.getLessonDate().getMonth().getValue() + "월";
        String day = lessonInfo.getLessonDate().getDayOfMonth() + "일";
        String startTime = TimeConvertor.calNewStartTime(lessonInfo.getStartTime());
        String hour = startTime.split(":")[0] + "시";
        String minute = startTime.split(":")[1] + "분";
        String lessonOneToN = "1:" + lessonInfo.getStudentCount();
        String lessonType = TimeConvertor.convertFromBitmask(lessonInfo.getLessonType());

        String detail = month + " " + day + " " + hour + " " + minute + " " + resortName + "\n" + lessonOneToN
                + " 강습이 예약되었습니다";


        return new LessonCreateInstructorEvent(
                receiverId,
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                "강습이 예약되었습니다",
                lessonInfo.getLessonDate().toString(),
                TimeConvertor.calLessonTimeInfo(lessonInfo.getStartTime(), lessonInfo.getDuration()),
                resortName,
                lessonInfo.getStudentCount().toString(),
                lessonType,
                paymentCacheDto.getStudentInfos()

        );
    }

}
