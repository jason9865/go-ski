package com.go.ski.payment.core.model;

import java.time.LocalDate;

import com.go.ski.user.core.model.User;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Settlement {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer settlementId;
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	@Column
	private Integer settlementAmount;
	@Column
	private Integer balance;
	@Column
	private LocalDate settlementDate;
	@Column
	private String payload;
	@Column
	private Integer depositStatus;
}
