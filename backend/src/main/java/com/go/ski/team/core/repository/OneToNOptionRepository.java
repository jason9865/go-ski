package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.OneToNOption;
import com.go.ski.team.core.model.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface OneToNOptionRepository extends JpaRepository<OneToNOption, Integer> {
    OneToNOption findByTeam(Team team);
}
