package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import lombok.Getter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@Getter
public class LessonResponseDTO {
    private final Integer lessonId;
    private final Integer teamId;
    private final String teamName;
    private final String resortName;
    private final LocalDate lessonDate;
    private final String startTime;
    private final Integer duration;
    private final String lessonStatus;

    public LessonResponseDTO(Lesson lesson, LessonInfo lessonInfo) {
        lessonId = lesson.getLessonId();
        teamId = lesson.getTeam().getTeamId();
        teamName = lesson.getTeam().getTeamName();
        resortName = lesson.getTeam().getSkiResort().getResortName();
        lessonDate = lessonInfo.getLessonDate();
        startTime = lessonInfo.getStartTime();
        duration = lessonInfo.getDuration();
        lessonStatus = getLessonStatus(lessonInfo, LocalDateTime.now());
    }

    public String getLessonStatus(LessonInfo lessonInfo, LocalDateTime currentDateTime) {
        return switch (lessonInfo.getLessonStatus()) {
            case 0 -> getLessonStatusForNotStarted(lessonInfo, currentDateTime);
            case 1 -> "yesFeedback";
            case 2 -> "cancelLesson";
            default -> "unknownStatus";
        };
    }

    private String getLessonStatusForNotStarted(LessonInfo lessonInfo, LocalDateTime currentDateTime) {
        LocalDateTime lessonStartDateTime = calculateLessonStartDateTime(lessonInfo);
        if (currentDateTime.isBefore(lessonStartDateTime)) {
            return "notStart";
        } else if (currentDateTime.isBefore(lessonStartDateTime.plusHours(lessonInfo.getDuration()))) {
            return "onGoing";
        } else {
            return "lessonFinished";
        }
    }

    private LocalDateTime calculateLessonStartDateTime(LessonInfo lessonInfo) {
        LocalDate lessonDate = lessonInfo.getLessonDate();
        String startTime = lessonInfo.getStartTime();

        LocalTime startTimeParsed = LocalTime.parse(startTime, DateTimeFormatter.ofPattern("HHmm"));
        return lessonDate.atTime(startTimeParsed);
    }
}
