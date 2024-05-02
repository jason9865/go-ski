package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.StudentInfo;
import lombok.Getter;

import java.util.List;

@Getter
public class InstructorLessonResponseDTO extends LessonResponseDTO {
    private List<StudentInfo> studentInfos;
    private String representativeName;
    private Integer studentCount;
    private Boolean isDesignated;

    public InstructorLessonResponseDTO(Lesson lesson, LessonInfo lessonInfo, List<StudentInfo> studentInfos, Boolean isDesignated) {
        super(lesson, lessonInfo);
        representativeName = lesson.getRepresentativeName();
        studentCount = lessonInfo.getStudentCount();
        this.studentInfos = studentInfos;
        this.isDesignated = isDesignated;
    }
}
