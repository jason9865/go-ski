package com.go.ski.team.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.team.core.model.Permission;

public interface PermissionRepository extends JpaRepository<Permission, Integer> {
}