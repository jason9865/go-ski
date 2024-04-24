package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.LevelOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface LevelOptionRepository extends JpaRepository<LevelOption, Integer> {
}
