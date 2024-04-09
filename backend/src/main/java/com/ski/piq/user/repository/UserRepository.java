package com.ski.piq.user.repository;

import com.ski.piq.oauth.dto.Domain;
import com.ski.piq.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByDomain(Domain domain);
}