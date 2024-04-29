package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class KakaopayPrepareResponseDTO {
	//현재 결제 건의 고유번호?(id)라고 생각하면 됨
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
	private LocalDate createdAt;
}