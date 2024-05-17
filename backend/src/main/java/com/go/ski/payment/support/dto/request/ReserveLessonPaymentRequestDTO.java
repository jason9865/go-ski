package com.go.ski.payment.support.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;
import lombok.Getter;

import java.time.LocalDate;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.StudentInfoDTO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReserveLessonPaymentRequestDTO {
	private Integer teamId;
	private Integer instId;
	private LocalDate lessonDate;
	private String startTime;// 4자리 숫자
	private Integer duration;
	private Integer peopleNumber;
	private String lessonType;
	private Integer basicFee;
	private Integer designatedFee;
	private Integer peopleOptionFee;
	private Integer levelOptionFee;
	private Integer level;
	// 쿠폰 활성화되면 합류
	// @JsonProperty("team_id")
	// private Integer	couponId;
	private List<StudentInfoDTO> studentInfo;
	private String requestComplain;
}
