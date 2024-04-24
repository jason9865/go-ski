package com.go.ski.team.core.repository;

import java.util.Optional;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.user.core.model.Instructor;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface TeamInstructorRepository extends JpaRepository<TeamInstructor, Integer> {
	Optional<TeamInstructor> findByTeamAndInstructor(Team team, Instructor instructor);
}
