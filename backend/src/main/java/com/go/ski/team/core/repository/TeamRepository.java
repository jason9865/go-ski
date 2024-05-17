package com.go.ski.team.core.repository;

import java.util.List;

import com.go.ski.payment.core.model.Lesson;
import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.support.dto.TeamInfoResponseDTO;
import com.go.ski.team.support.dto.TeamResponseDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface TeamRepository extends JpaRepository<Team, Integer>, TeamRepositoryCustom {

    @Query("SELECT " +
            "new com.go.ski.team.support.dto.TeamResponseDTO(" +
            "team.teamId, team.teamName, team.teamProfileUrl, team.description, skiResort.resortName) " +
            "FROM Team team " +
            "LEFT OUTER JOIN SkiResort skiResort ON team.skiResort.resortId = skiResort.resortId " +
            "WHERE team.user.userId = :userId")
    List<TeamResponseDTO> findOwnerTeamList(Integer userId);

    @Query("SELECT " +
            "new com.go.ski.team.support.dto.TeamResponseDTO(" +
            "ti.team.teamId, team.teamName, team.teamProfileUrl, team.description, skiResort.resortName) " +
            "FROM Team team " +
            "LEFT OUTER JOIN TeamInstructor  ti ON team.teamId = ti.team.teamId " +
            "LEFT OUTER JOIN SkiResort skiResort ON team.skiResort.resortId = skiResort.resortId " +
            "WHERE ti.instructor.instructorId = :userId")
    List<TeamResponseDTO> findInstTeamList(Integer userId);

    List<Team> findBySkiResort(SkiResort skiResort);
}
