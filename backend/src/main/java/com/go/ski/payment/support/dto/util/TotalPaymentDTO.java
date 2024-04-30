package com.go.ski.payment.support.dto.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class TotalPaymentDTO {
	private Integer totalAmount;
	private Integer paymentStatus;
	private Integer chargeRate;
}
