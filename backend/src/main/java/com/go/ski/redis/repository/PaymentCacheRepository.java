package com.go.ski.redis.repository;

import org.springframework.data.repository.CrudRepository;

import com.go.ski.redis.dto.PaymentCacheDto;

public interface PaymentCacheRepository extends CrudRepository<PaymentCacheDto, String> {
}
