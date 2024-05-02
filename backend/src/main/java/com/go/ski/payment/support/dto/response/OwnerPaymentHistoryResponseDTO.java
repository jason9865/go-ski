package com.go.ski.payment.support.dto.response;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class OwnerPaymentHistoryResponseDTO {
	private String teamName;
	private String studentName;
	// private String instructorName; // 굳이 필요한가?
	private LocalDate paymentDate;
	private String chargeName;
	private Integer charge;
	private Integer totalAmount;
	private Integer basicFee;
	private Integer designatedFee;
	private Integer peopleOptionFee;
	private Integer levelOptionFee;
}
