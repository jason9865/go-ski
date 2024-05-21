package com.go.ski.payment.support.dto.util;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class CardInfo {
	@JsonProperty("interest_free_install")
	private String interestFreeInstall;
	@JsonProperty("bin")
	private String bin;
	@JsonProperty("card_type")
	private String cardType;
	@JsonProperty("card_mid")
	private String cardMid;
	@JsonProperty("approved_id")
	private String approvedId;
	@JsonProperty("install_month")
	private String installMonth;
	@JsonProperty("purchase_corp")
	private String purchaseCorp;
	@JsonProperty("purchase_corp_code")
	private String purchaseCorpCode;
	@JsonProperty("issuer_corp")
	private String issuerCorp;
	@JsonProperty("issuer_corp_code")
	private String issuerCorpCode;
	@JsonProperty("kakaopay_purchase_corp")
	private String kakaopayPurchaseCorp;
	@JsonProperty("kakaopay_purchase_corp_code")
	private String kakaopayPurchaseCorpCode;
	@JsonProperty("kakaopay_issuer_corp")
	private String kakaopayIssuerCorp;
	@JsonProperty("kakaopay_issuer_corp_code")
	private String kakaopayIssuerCorpCode;
}
