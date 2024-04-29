package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
public class UserLessonResponseDTO {
    Integer teamId;
    String teamName;
    Integer instructorId;
    String instructorName;
    String profileUrl;
    String resortName;
    LocalDate lessonDate;
    String startTime;
    Integer duration;

    public UserLessonResponseDTO(Lesson lesson, LessonInfo lessonInfo) {
        teamId = lesson.getTeam().getTeamId();
        teamName = lesson.getTeam().getTeamName();
        instructorId = lesson.getInstructor().getInstructorId();
        instructorName = lesson.getInstructor().getUser().getUserName();
        profileUrl = lesson.getInstructor().getUser().getProfileUrl();
        resortName = lesson.getTeam().getSkiResort().getResortName();
        lessonDate = lessonInfo.getLessonDate();
        startTime = lessonInfo.getStartTime();
        duration = lessonInfo.getDuration();
    }
}
