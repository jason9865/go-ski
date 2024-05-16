package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import lombok.Getter;

import java.util.List;

@Getter
public class InstructorLessonResponseDTO extends LessonResponseDTO {
    private List<StudentInfoResponseDTO> studentInfoResponseDTOs;
    private String representativeName;
    private Integer studentCount;
    private Boolean isDesignated;

    public InstructorLessonResponseDTO(Lesson lesson, LessonInfo lessonInfo, List<StudentInfoResponseDTO> studentInfoResponseDTOs, Boolean isDesignated) {
        super(lesson, lessonInfo);
        representativeName = lesson.getRepresentativeName();
        studentCount = lessonInfo.getStudentCount();
        this.studentInfoResponseDTOs = studentInfoResponseDTOs;
        this.isDesignated = isDesignated;
    }
}
