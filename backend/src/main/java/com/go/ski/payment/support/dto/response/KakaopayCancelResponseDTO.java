package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.Amount;

import lombok.Getter;

@Getter
public class KakaopayCancelResponseDTO {
	private String aid;
	private String tid;
	private String cid;
	private String status;
	@JsonProperty("partner_order_id")
	private String partnerOrderId;
	@JsonProperty("partner_user_id")
	private String partnerUserId;
	@JsonProperty("payment_method_type")
	private String paymentMethodType;
	private Amount amount;
	@JsonProperty("approved_cancel_amount")
	private Amount approvedCancelAmount;
	@JsonProperty("canceled_amount")
	private Amount canceledAmount;
	@JsonProperty("item_name")
	private Amount cancelAvailableAmount;
	@JsonProperty("item_name")
	private String itemName;
	@JsonProperty("item_code")
	private String itemCode;
	private Integer quantity;
	@JsonProperty("created_at")
	private LocalDate createdAt;
	@JsonProperty("approved_at")
	private LocalDate approvedAt;
	@JsonProperty("canceled_at")
	private LocalDate canceledAt;
	private String payload;
}
