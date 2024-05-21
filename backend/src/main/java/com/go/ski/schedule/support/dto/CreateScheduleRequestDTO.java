package com.go.ski.schedule.support.dto;

import com.go.ski.lesson.support.dto.ReserveRequestDTO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class CreateScheduleRequestDTO extends ReserveRequestDTO {
    private Integer teamId;
    private Integer instructorId;
    private String userName; // 예약자
    private String content; // 특이사항
}
