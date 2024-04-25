package com.go.ski.lesson.support.vo;

import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.support.vo.IsInstructAvailable;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LessonScheduleVO {
    private Integer instructorId;
    private IsInstructAvailable isInstructAvailable;
    private long timeTable; // 2진수로 비트마스킹
    private int totalTime;

    public LessonScheduleVO(Instructor instructor) {
        instructorId = instructor.getInstructorId();
        isInstructAvailable = instructor.getIsInstructAvailable();
        timeTable = 281474976710656L;
        totalTime = 0;
    }
}
