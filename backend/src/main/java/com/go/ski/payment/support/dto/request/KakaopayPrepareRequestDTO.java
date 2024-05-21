package com.go.ski.payment.support.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.core.model.Lesson;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class KakaopayPrepareRequestDTO {
	private String partnerOrderId;
	private String partnerUserId;
	private String itemName;
	private Integer quantity;
	private Integer totalAmount;
	private Integer taxFreeAmount;

	public static KakaopayPrepareRequestDTO toKakaopayPrepareRequestDTO(Lesson lesson, String itemName, Integer totalFee) {
		totalFee = totalFee * (10/11);
		return KakaopayPrepareRequestDTO.builder()
			.partnerOrderId("partner_order_id")
			.partnerUserId(String.valueOf(lesson.getUser().getUserId()))
			.itemName(itemName)
			.quantity(1)//고정
			.totalAmount(totalFee)
			.taxFreeAmount(0)//고정
			.build();
	}
}
