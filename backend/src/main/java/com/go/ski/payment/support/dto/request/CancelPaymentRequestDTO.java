package com.go.ski.payment.support.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class CancelPaymentRequestDTO {

	@JsonProperty("lesson_id")
	private Integer lessonId;
}
