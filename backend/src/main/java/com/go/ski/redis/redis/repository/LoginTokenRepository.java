package com.go.ski.redis.redis.repository;


import com.go.ski.redis.redis.dto.LoginTokenDto;
import org.springframework.data.repository.CrudRepository;

public interface LoginTokenRepository extends CrudRepository<LoginTokenDto, String> {
}