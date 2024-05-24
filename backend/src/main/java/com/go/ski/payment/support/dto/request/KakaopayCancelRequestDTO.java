package com.go.ski.payment.support.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class KakaopayCancelRequestDTO {
	private String cid;
	private String tid;
	private Integer cancelAmount;
	private Integer cancelTaxFreeAmount;
	private Integer cancelVatAmount;
	//사용할 수 있는 것
	/*
	* 어떻게 활용할지 고민하기
	* payload 해당 요청에 대해 저장하고 싶은 값
	* */
}
