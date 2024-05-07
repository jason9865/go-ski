package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;

@Getter
public class KakaopayPrepareResponseDTO {
	//현재 결제 건의 고유번호?(id)라고 생각하면 됨
	private String tid;
	private String nextRedirectAppUrl;
	private String nextRedirectMobileUrl;
	private String nextRedirectPcUrl;
	private String androidAppScheme;
	private String iosAppScheme;
	private LocalDate createdAt;
}