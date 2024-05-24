package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.payment.support.dto.util.Amount;
import com.go.ski.payment.support.dto.util.CardInfo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class KakaopayApproveResponseDTO {
	private String aid;
	private String tid;
	private String cid;
	private String sid;
	@JsonProperty("partner_order_id")
	private String partnerOrderId;
	@JsonProperty("partner_user_id")
	private String partnerUserId;
	@JsonProperty("payment_method_type")
	private String paymentMethodType;
	private Amount amount;
	@JsonProperty("card_info")
	private CardInfo cardInfo;
	@JsonProperty("item_name")
	private String itemName;
	@JsonProperty("item_code")
	private String itemCode;
	private int quantity;
	@JsonProperty("created_at")
	private LocalDate createdAt;
	@JsonProperty("approved_at")
	private LocalDate approvedAt;
}
