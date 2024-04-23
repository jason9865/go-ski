package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.TeamInstructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TeamInstructorRepository extends JpaRepository<TeamInstructor, Integer> {
}
