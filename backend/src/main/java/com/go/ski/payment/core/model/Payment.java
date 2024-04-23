package com.go.ski.payment.core.model;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;

@Getter
@Entity
public class Payment {
	@Id
	private Integer paymentId;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lesson_id")
	private LessonPaymentInfo LessonPaymentInfo;// 1대 다 lesson_payment_info
	@Column
	private Integer totalAmount;
	@Column
	private Integer paymentStatus;
	@Column
	private Integer chargeId;//0은 사용자, 100?
	@Column
	private LocalDate paymentDate;
}
