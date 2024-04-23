package com.go.ski.payment.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
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
	@JsonProperty("approval_url")
	private String approvalUrl;
	@JsonProperty("fail_url")
	private String failUrl;
	@JsonProperty("cancel_url")
	private String cancelUrl;
}
