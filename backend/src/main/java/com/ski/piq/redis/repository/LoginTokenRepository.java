package com.ski.piq.redis.repository;


import com.ski.piq.redis.dto.LoginTokenDto;
import org.springframework.data.repository.CrudRepository;

public interface LoginTokenRepository extends CrudRepository<LoginTokenDto, String> {
}