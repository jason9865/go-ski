package com.go.ski.payment.support.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.user.core.model.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class KakaopayPrepareRequestDTO {
	@JsonProperty("partner_order_id")
	private String partnerOrderId;
	@JsonProperty("partner_user_id")
	private String partnerUserId;
	@JsonProperty("item_name")
	private String itemName;
	private Integer quantity;
	@JsonProperty("total_amount")
	private Integer totalAmount;
	@JsonProperty("tax_free_amount")
	private Integer taxFreeAmount;

	public static KakaopayPrepareRequestDTO toKakaopayPrepareRequestDTO(Lesson lesson, String itemName, Integer totalFee) {
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
