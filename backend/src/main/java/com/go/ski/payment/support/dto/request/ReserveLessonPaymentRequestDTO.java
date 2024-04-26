package com.go.ski.payment.support.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;

@Getter
public class ReserveLessonPaymentRequestDTO {
    @JsonProperty("team_id")
    private Integer teamId;
    @JsonProperty("inst_id")
    private Integer instId;
    @JsonProperty("lesson_date")
    private LocalDate lessonDate;
    @JsonProperty("start_time")
    private String startTime;// 4자리 숫자
    private Integer duration;
    private Integer peopleNumber;
    private Integer level;
    private String lessonType;
    @JsonProperty("has_instruct")
    private Boolean hasInstruct;
    // 쿠폰 활성화되면 합류
    // @JsonProperty("team_id")
    // private Integer	couponId;
    @JsonProperty("student_info")
    private List<StudentInfoDTO> studentInfo;
}
