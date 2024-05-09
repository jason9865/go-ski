package com.go.ski.lesson.support.dto;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.user.core.model.Instructor;
import lombok.Getter;

@Getter
public class UserLessonResponseDTO extends LessonResponseDTO {
    private Integer instructorId;
    private String instructorName;
    private String profileUrl;
    private final Integer studentCount;
    private final Boolean hasReview;
    public UserLessonResponseDTO(Lesson lesson, LessonInfo lessonInfo, Boolean hasReview) {
        super(lesson, lessonInfo);
        Instructor instructor = lesson.getInstructor();
        if (instructor != null) {
            instructorId = instructor.getInstructorId();
            instructorName = instructor.getUser().getUserName();
            profileUrl = instructor.getUser().getProfileUrl();
        }
        this.studentCount = lessonInfo.getStudentCount();
        this.hasReview = hasReview;
    }
}
