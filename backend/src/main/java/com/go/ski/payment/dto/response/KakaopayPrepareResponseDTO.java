package com.go.ski.payment.dto.response;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class KakaopayPrepareResponseDTO {
	private String tid;
	@JsonProperty("next_redirect_app_url")
	private String nextRedirectAppUrl;
	@JsonProperty("next_redirect_mobile_url")
	private String nextRedirectMobileUrl;
	@JsonProperty("next_redirect_pc_url")
	private String nextRedirectPcUrl;
	@JsonProperty("android_app_scheme")
	private String androidAppScheme;
	@JsonProperty("ios_app_scheme")
	private String iosAppScheme;
	@JsonProperty("created_at")
	private Date createdAt;
}