package com.go.ski.redis.repository;


import com.go.ski.redis.dto.LoginTokenDto;
import org.springframework.data.repository.CrudRepository;

public interface LoginTokenRepository extends CrudRepository<LoginTokenDto, String> {
}