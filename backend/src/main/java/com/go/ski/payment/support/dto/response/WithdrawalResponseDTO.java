package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class WithdrawalResponseDTO {
	private Integer settlementAmount;
	private String bank;
	private String depositorName;
	private String accountNumber;
	private Integer balance;
	private LocalDate settlementDate;
}
