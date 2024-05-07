package com.go.ski.payment.support.dto.request;

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
	private String partnerOrderId;
	private String partnerUserId;
	private String pgToken;
}
