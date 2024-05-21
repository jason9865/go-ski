package com.go.ski.payment.support.dto.request;

import lombok.Getter;

@Getter
public class ApprovePaymentRequestDTO {
	private String tid;
	private String partnerOrderId;
	private String partnerUserId;
	private String pgToken;
}
