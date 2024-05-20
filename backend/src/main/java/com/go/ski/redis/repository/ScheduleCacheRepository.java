package com.go.ski.redis.repository;

import com.go.ski.redis.dto.ScheduleCacheDto;
import org.springframework.data.repository.CrudRepository;

public interface ScheduleCacheRepository extends CrudRepository<ScheduleCacheDto, String> {
}