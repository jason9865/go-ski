package com.go.ski.payment.support.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class KakaopayApproveRequestDTO {
	private String tid;
	@JsonProperty("partner_order_id")
	private String partnerOrderId;
	@JsonProperty("partner_user_id")
	private String partnerUserId;
	@JsonProperty("pg_token")
	private String pgToken;
}
