package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.SkiResort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SkiResortRepository extends JpaRepository<SkiResort, Integer> {
}
