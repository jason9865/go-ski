package com.go.ski.payment.support.dto.request;

import static jakarta.persistence.EnumType.*;

import java.time.LocalDate;
import java.util.List;

import org.joda.time.DateTime;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import com.go.ski.payment.support.vo.LessonType;

import jakarta.persistence.Enumerated;
import lombok.Getter;

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
	@Enumerated(STRING)
	private LessonType lessonType;
	@JsonProperty("has_instruct")
	private Boolean hasInstruct;
	// 쿠폰 활성화되면 합류
	// @JsonProperty("team_id")
	// private Integer	couponId;
	@JsonProperty("student_info")
	private List<StudentInfoDTO> studentInfo;
}
