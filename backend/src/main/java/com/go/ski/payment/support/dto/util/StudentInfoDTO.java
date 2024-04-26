package com.go.ski.payment.support.dto.util;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.user.support.vo.Gender;

import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.Getter;

@Getter
public class StudentInfoDTO {
	@Enumerated(EnumType.STRING)
	private String height;
	@Enumerated(EnumType.STRING)
	private String weight;
	@JsonProperty("foot_size")
	private Integer footSize;
	@Enumerated(EnumType.STRING)
	private String age;
	@Enumerated(EnumType.STRING)
	private Gender gender;
	private String name;
}
