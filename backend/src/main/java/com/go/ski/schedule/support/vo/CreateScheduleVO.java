package com.go.ski.schedule.support.vo;

import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.schedule.support.dto.CreateScheduleRequestDTO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@NoArgsConstructor
@ToString
public class CreateScheduleVO extends ReserveInfoVO {
    private Integer lessonId;
    private Integer teamId;
    private String representativeName;
    private String requestComplain;
    private Boolean isDesignated;
    @Setter
    private Integer instructorId;

    public CreateScheduleVO(CreateScheduleRequestDTO createScheduleRequestDTO) {
        super(createScheduleRequestDTO);
        teamId = createScheduleRequestDTO.getTeamId();
        instructorId = createScheduleRequestDTO.getInstructorId();
        isDesignated = instructorId != null;
        representativeName = createScheduleRequestDTO.getUserName();
        requestComplain = createScheduleRequestDTO.getContent();
    }
}
