package com.go.ski.user.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UpdateInstructorRequestDTO extends InstructorImagesDTO {
    private String description;
    private String lessonType;
    private Integer dayoff;
}
