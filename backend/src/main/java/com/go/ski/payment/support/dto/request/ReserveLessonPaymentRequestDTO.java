package com.go.ski.payment.support.dto.request;

import static jakarta.persistence.EnumType.*;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;

import jakarta.persistence.Enumerated;
import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
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
	@JsonProperty("lesson_type")
	private String lessonType;
	@JsonProperty("basic_fee")
	private Integer basicFee;
	@JsonProperty("designated_fee")
	private Integer designatedFee;
	@JsonProperty("people_option_fee")
	private Integer peopleOptionFee;
	@JsonProperty("level_option_fee")
	private Integer levelOptionFee;
	// 쿠폰 활성화되면 합류
	// @JsonProperty("team_id")
	// private Integer	couponId;
	@JsonProperty("student_info")
	private List<StudentInfoDTO> studentInfo;
}
