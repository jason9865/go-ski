package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.payment.core.model.StudentInfo;
import lombok.Getter;

import java.util.List;

@Getter
public class InstructorLessonResponseDTO extends LessonResponseDTO {
    List<StudentInfo> studentInfos;

    public InstructorLessonResponseDTO(Lesson lesson, LessonInfo lessonInfo, List<StudentInfo> studentInfos) {
        super(lesson, lessonInfo);
        this.studentInfos = studentInfos;
    }
}
