package com.go.ski.payment.support.dto.response;

import lombok.Getter;
@Getter
public class LessonCostResponseDTO {
	private final Integer cost;
	private final Integer paybackRate;

	public LessonCostResponseDTO(Integer cost, Integer paybackRate) {
		this.cost = cost;
		this.paybackRate = paybackRate;
	}
}
