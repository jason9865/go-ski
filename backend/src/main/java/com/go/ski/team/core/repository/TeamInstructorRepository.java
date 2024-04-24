package com.go.ski.team.core.repository;

import java.util.List;
import java.util.Optional;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.user.core.model.Instructor;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;


public interface TeamInstructorRepository extends JpaRepository<TeamInstructor, Integer>, TeamInstructorCustom {

    @Query("SELECT ti " +
            "FROM TeamInstructor ti " +
            "WHERE ti.instructor.user.userId = :instructorId")
    Optional<TeamInstructor> findTeamInstructorByInstructorId(Integer instructorId);

	Optional<TeamInstructor> findByTeamAndInstructor(Team team, Instructor instructor);

    Optional<TeamInstructor> findByTeam(Team team);

    Optional<List<TeamInstructor>> findAllByTeam(Team team);

}
