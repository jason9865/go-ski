package com.go.ski.lesson.support.dto;

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
}
