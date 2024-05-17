package com.go.ski.user.core.repository;

import com.go.ski.auth.oauth.dto.Domain;
import com.go.ski.user.core.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByDomain(Domain domain);
}