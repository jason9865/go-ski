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

    private final String totalAmount;
    private final String lessonDate;
    private final String lessonTime;
    private final String resortName;
    private final String studentCount;
    private final String lessonType;
    private final List<StudentInfoDTO> studentInfos;

    public LessonCreateInstructorEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType, String title,
            String totalAmount,String lessonDate,
            String lessonTime, String resortName,
            String studentCount, String lessonType,
            List<StudentInfoDTO> studentInfos) {
        super(receiverId, createdAt, notificationType, deviceType, title);
        this.totalAmount = totalAmount;
        this.lessonDate = lessonDate;
        this.lessonTime = lessonTime;
        this.resortName = resortName;
        this.studentCount = studentCount;
        this.lessonType = lessonType;
        this.studentInfos = studentInfos;

    }

    public static LessonCreateInstructorEvent of(LessonInfo lessonInfo, String resortName,
                  Integer receiverId, PaymentCacheDto paymentCacheDto, String deviceType) {

        String lessonType = TimeConvertor.convertFromBitmask(lessonInfo.getLessonType());

        String totalAmount = paymentCacheDto.getLessonPaymentInfo().getBasicFee() +
                paymentCacheDto.getLessonPaymentInfo().getPeopleOptionFee() +
                paymentCacheDto.getLessonPaymentInfo().getDesignatedFee() +
                paymentCacheDto.getLessonPaymentInfo().getLevelOptionFee().toString();

        return new LessonCreateInstructorEvent(
                receiverId,
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                "강습이 예약되었습니다", // title
                totalAmount,
                lessonInfo.getLessonDate().toString(),
                TimeConvertor.calLessonTimeInfo(lessonInfo.getStartTime(), lessonInfo.getDuration()),
                resortName,
                lessonInfo.getStudentCount().toString(),
                lessonType,
                paymentCacheDto.getStudentInfos()

        );
    }

}
