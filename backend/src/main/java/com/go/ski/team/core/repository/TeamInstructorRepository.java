package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.user.core.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;


public interface TeamInstructorRepository extends JpaRepository<TeamInstructor, Integer>, TeamInstructorCustom {

    @Query("SELECT ti " +
            "FROM TeamInstructor ti " +
            "WHERE ti.instructor.user.userId = :instructorId")
    Optional<TeamInstructor> findTeamInstructorByInstructorId(Integer instructorId);

    Optional<TeamInstructor> findByTeamAndInstructor(Team team, Instructor instructor);

    List<TeamInstructor> findByTeamAndIsInviteAccepted(Team team, boolean isInviteAccepted);

    Optional<TeamInstructor> findByTeamTeamIdAndInstructorInstructorIdAndIsInviteAccepted(Integer teamId, Integer instructorId, boolean isInviteAccepted);

    Optional<List<TeamInstructor>> findByTeam(Team team);


}
