package com.go.ski.lesson.support.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveRequestDTO extends ReserveRequestFrameDTO {
    private String lessonType;
    private String level;
}
