package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.LevelOption;
import com.go.ski.team.core.model.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

public interface LevelOptionRepository extends JpaRepository<LevelOption, Integer> {

    LevelOption findByTeam(Team team);

}
