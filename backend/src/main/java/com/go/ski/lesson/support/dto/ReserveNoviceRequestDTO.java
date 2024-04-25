package com.go.ski.lesson.support.dto;

import com.go.ski.payment.support.vo.LessonType;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveNoviceRequestDTO {
    private Integer resortId;
    private Integer studentCount;
    private LessonType lessonType;
    private LocalDate lessonDate;
    private String startTime;
    private Integer duration;

    public ReserveNoviceRequestDTO(ReserveNoviceRequestDTO reserveNoviceRequestDTO) {
        this.resortId = reserveNoviceRequestDTO.getResortId();
        this.studentCount = reserveNoviceRequestDTO.getStudentCount();
        this.lessonType = reserveNoviceRequestDTO.getLessonType();
        this.lessonDate = reserveNoviceRequestDTO.getLessonDate();
        this.startTime = reserveNoviceRequestDTO.getStartTime();
        this.duration = reserveNoviceRequestDTO.getDuration();
    }
}
