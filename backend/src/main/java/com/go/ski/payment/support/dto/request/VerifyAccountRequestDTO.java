package com.go.ski.payment.support.dto.request;

import lombok.Getter;

@Getter
public class VerifyAccountRequestDTO {

	private String name; // 예금주명
	private String bank; // 사용 계좌 은행 코드
	private String account; // 계좌 번호
	private String identity; // 생년월일(YYMMDD) 6자리/사업자등록번호 10자리

}
