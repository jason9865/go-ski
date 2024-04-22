package com.go.ski.payment.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class KakaopayApproveRequestDTO {
	private String tid;
	@JsonProperty("partner_order_id")
	private String partnerOrderId;
	@JsonProperty("partner_user_id")
	private String partnerUserId;
	@JsonProperty("pg_token")
	private String pgToken;
}
