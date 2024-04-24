package com.go.ski.payment.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.payment.core.model.Charge;

public interface ChargeRepository extends JpaRepository<Charge, Integer> {
}
