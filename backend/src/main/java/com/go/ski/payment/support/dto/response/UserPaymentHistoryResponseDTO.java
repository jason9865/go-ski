package com.go.ski.payment.support.dto.response;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class UserPaymentHistoryResponseDTO {
	private String userName;//필요한가?
	private String teamName;
	private LocalDateTime paymentDate;
	private Integer paymentStatus;
	private String chargeName;
	private Integer charge;
	private Integer totalAmount;
	private Integer basicFee;
	private Integer designatedFee;
	private Integer peopleOptionFee;
	private Integer levelOptionFee;
}
