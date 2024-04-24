package com.go.ski.payment.support.dto.util;

import static jakarta.persistence.EnumType.*;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.vo.Age;
import com.go.ski.payment.support.vo.Height;
import com.go.ski.payment.support.vo.Weight;
import com.go.ski.user.support.vo.Gender;

import jakarta.persistence.Enumerated;
import lombok.Getter;

@Getter
public class StudentInfoDTO {
	@Enumerated(STRING)
	private Height height;
	@Enumerated(STRING)
	private Weight weight;
	@JsonProperty("foot_size")
	private Integer footSize;
	@Enumerated(STRING)
	private Age age;
	@Enumerated(STRING)
	private Gender gender;
	private String name;
}
