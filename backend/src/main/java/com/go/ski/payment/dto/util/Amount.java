package com.go.ski.payment.dto.util;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class Amount {
	@JsonProperty("total")
	private int total;
	@JsonProperty("tax_free")
	private int taxFree;
	@JsonProperty("vat")
	private int vat;
	@JsonProperty("point")
	private int point;
	@JsonProperty("discount")
	private int discount;
	@JsonProperty("green_deposit")
	private int greenDeposit;

}