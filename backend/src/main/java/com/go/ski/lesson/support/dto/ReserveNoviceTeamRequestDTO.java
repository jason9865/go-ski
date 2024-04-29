package com.go.ski.lesson.support.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReserveNoviceTeamRequestDTO {
    private Integer studentCount;
    private String level;
    private Integer duration;
    private List<Integer> instructorsList;
}
