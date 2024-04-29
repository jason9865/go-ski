package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class UserPaymentHistoryResponseDTO {
	private String userName;
	private String teamName;
	private LocalDate paymentDate;
	private Integer paymentStatus;
	private String chargeName;
	private Integer charge;
	private Integer totalAmount;
	private Integer basicFee;
	private Integer designatedFee;
	private Integer peopleOptionFee;
	private Integer levelOptionFee;
}
