package com.go.ski.team.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.team.core.model.Permission;
import org.springframework.stereotype.Repository;

public interface PermissionRepository extends JpaRepository<Permission, Integer> {
}