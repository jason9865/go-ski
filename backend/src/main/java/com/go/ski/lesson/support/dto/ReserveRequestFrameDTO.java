package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.redis.dto.PaymentCacheDto;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveRequestFrameDTO {
    private Integer resortId;
    private Integer studentCount;
    private LocalDate lessonDate;
    private String startTime;
    private Integer duration;

    public ReserveRequestFrameDTO(ReserveRequestDTO reserveRequestDTO) {
        resortId = reserveRequestDTO.getResortId();
        studentCount = reserveRequestDTO.getStudentCount();
        lessonDate = reserveRequestDTO.getLessonDate();
        startTime = reserveRequestDTO.getStartTime();
        duration = reserveRequestDTO.getDuration();
    }

    public ReserveRequestFrameDTO(PaymentCacheDto paymentCacheDto) {
        LessonInfo lessonInfo = paymentCacheDto.getLessonInfo();
        resortId = paymentCacheDto.getLesson().getTeam().getSkiResort().getResortId();
        studentCount = lessonInfo.getStudentCount();
        lessonDate = lessonInfo.getLessonDate();
        startTime = lessonInfo.getStartTime();
        duration = lessonInfo.getDuration();
    }

    public ReserveRequestFrameDTO(LessonInfo lessonInfo) {
        resortId = lessonInfo.getLesson().getTeam().getSkiResort().getResortId();
        studentCount = lessonInfo.getStudentCount();
        lessonDate = lessonInfo.getLessonDate();
        startTime = lessonInfo.getStartTime();
        duration = lessonInfo.getDuration();
    }
}
