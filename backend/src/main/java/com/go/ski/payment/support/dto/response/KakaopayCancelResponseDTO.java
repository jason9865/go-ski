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
	private String partnerOrderId;
	private String partnerUserId;
	private String paymentMethodType;
	private Amount amount;
	private Amount approvedCancelAmount;
	private Amount canceledAmount;
	private Amount cancelAvailableAmount;
	private String itemName;
	private String itemCode;
	private Integer quantity;
	private LocalDate createdAt;
	private LocalDate approvedAt;
	private LocalDate canceledAt;
	private String payload;
}
