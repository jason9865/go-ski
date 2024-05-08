package com.go.ski.notification.support.events;

import com.go.ski.feedback.support.dto.FeedbackCreateRequestDTO;
import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.payment.core.model.Lesson;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class FeedbackEvent extends NotificationEvent{

    private static final Integer NOTIFICATION_TYPE = 8;

    private final Integer lessonId;

    private FeedbackEvent(
            Integer receiverId, LocalDateTime createdAt,
            Integer notificationType, DeviceType deviceType,
            String title, Integer lessonId){
        super(receiverId, createdAt, notificationType, deviceType,title);
        this.lessonId = lessonId;
    }

    public static FeedbackEvent of(FeedbackCreateRequestDTO feedbackCreateRequestDTO, Lesson lesson, String deviceType) {
        return new FeedbackEvent(
                lesson.getUser().getUserId(),
                LocalDateTime.now(),
                NOTIFICATION_TYPE,
                DeviceType.valueOf(deviceType),
                lesson.getInstructor().getUser().getUserName() + " 강사로부터 피드백이 등록되었습니다.",
                lesson.getLessonId()
        );
    }

}
