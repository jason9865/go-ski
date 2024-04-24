package com.go.ski.payment.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.payment.core.model.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {
}
