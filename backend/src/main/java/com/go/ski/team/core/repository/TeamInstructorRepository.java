package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.support.dto.TeamInstructorResponseDTO;
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

    @Query("SELECT ti.teamInstructorId " +
            "FROM TeamInstructor ti " +
            "WHERE ti.instructor.user.userId = :instructorId AND ti.team.teamId = :teamId")
    Integer findTeamInstructorIdByInstructorIdAndTeamId(Integer instructorId, Integer teamId);

    Optional<TeamInstructor> findByTeamAndInstructor(Team team, Instructor instructor);

    List<TeamInstructor> findByTeamAndIsInviteAccepted(Team team, boolean isInviteAccepted);

    Optional<TeamInstructor> findByTeamTeamIdAndInstructorInstructorIdAndIsInviteAccepted(Integer teamId, Integer instructorId, boolean isInviteAccepted);

    Optional<List<TeamInstructor>> findByTeam(Team team);

    @Query("SELECT new com.go.ski.team.support.dto.TeamInstructorResponseDTO(" +
            "ti.instructor.instructorId, u.userName, u.phoneNumber, u.profileUrl, p.position) " +
            "FROM TeamInstructor ti " +
            "LEFT OUTER JOIN User u " +
            "ON ti.instructor.instructorId = u.userId " +
            "LEFT OUTER JOIN Permission p " +
            "ON ti.teamInstructorId = p.teamInstructorId " +
            "WHERE ti.team.teamId = :teamId")
    List<TeamInstructorResponseDTO> findByTeamId(Integer teamId);


}
