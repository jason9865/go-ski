package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.Team;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TeamRepository extends JpaRepository<Team,Integer> {
}
