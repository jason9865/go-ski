package com.go.ski.payment.core.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Builder
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer paymentId;
	@Column
	private String tid;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "lesson_id")
	private LessonPaymentInfo lessonPaymentInfo;// 1대 다 lesson_payment_info
	@Column
	private Integer totalAmount;
	@Column
	private Integer paymentStatus;
	@Column
	private Integer chargeId;//0은 사용자, 100?
	@Column
	private LocalDateTime paymentDate;
	@Column
	private LocalDateTime paybackDate;
}