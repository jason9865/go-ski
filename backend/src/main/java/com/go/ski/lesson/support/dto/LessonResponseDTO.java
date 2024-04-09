package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import lombok.Getter;

import java.time.LocalDate;

@Getter
public class LessonResponseDTO {
    private Integer lessonId;
    private Integer teamId;
    private String teamName;
    private String resortName;
    private LocalDate lessonDate;
    private String startTime;
    private Integer duration;

    public LessonResponseDTO(Lesson lesson, LessonInfo lessonInfo) {
        lessonId = lesson.getLessonId();
        teamId = lesson.getTeam().getTeamId();
        teamName = lesson.getTeam().getTeamName();
        resortName = lesson.getTeam().getSkiResort().getResortName();
        lessonDate = lessonInfo.getLessonDate();
        startTime = lessonInfo.getStartTime();
        duration = lessonInfo.getDuration();
    }
}
