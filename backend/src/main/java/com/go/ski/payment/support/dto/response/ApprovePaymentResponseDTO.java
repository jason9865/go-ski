package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import com.go.ski.payment.support.dto.util.Amount;
import com.go.ski.payment.support.dto.util.CardInfo;

import lombok.Getter;

@Getter
public class ApprovePaymentResponseDTO {
	private String aid;
	private String tid;
	private String cid;
	private String sid;
	private String partnerOrderId;
	private String partnerUserId;
	private String paymentMethodType;
	private Amount amount;
	private CardInfo cardInfo;
	private String itemName;
	private String itemCode;
	private int quantity;
	private LocalDate createdAt;
	private LocalDate approvedAt;
}
