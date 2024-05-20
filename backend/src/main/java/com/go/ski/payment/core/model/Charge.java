package com.go.ski.payment.core.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Getter;

@Getter
@Entity
public class Charge {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer chargeId;
	@Column
	private String chargeName;
	@Column
	private Integer studentChargeRate;
	@Column
	private Integer ownerChargeRate;
	@Column
	private Integer systemChargeRate;
}
