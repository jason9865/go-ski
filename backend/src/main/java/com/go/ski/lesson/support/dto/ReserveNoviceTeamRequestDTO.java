package com.go.ski.lesson.support.dto;

import com.go.ski.lesson.support.vo.ReserveInfoVO;
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
    private String lessonType;

    public  ReserveNoviceTeamRequestDTO(ReserveInfoVO reserveInfoVO) {
        studentCount = reserveInfoVO.getStudentCount();
        duration = reserveInfoVO.getDuration();
        level = switch (reserveInfoVO.getLessonType()) {
            case "1010010", "1101000" -> "INTERMEDIATE";
            case "1010011", "1101100" -> "ADVANCED";
            default -> null;
        };
        lessonType = reserveInfoVO.getLessonType();
    }
}
