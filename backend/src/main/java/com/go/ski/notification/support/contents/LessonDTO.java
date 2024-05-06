package com.go.ski.notification.support.contents;

import com.go.ski.payment.core.model.Lesson;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class LessonDTO {

    private Integer userId;
    private String representativeName;


    public static LessonDTO toDto(Lesson lesson) {
        return LessonDTO.builder()
                .userId(lesson.getUser().getUserId())
                .representativeName(lesson.getRepresentativeName())
                .build();

    }

}
