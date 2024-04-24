package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.Team;
import com.go.ski.team.support.dto.TeamInfoResponseDTO;
import com.go.ski.team.support.dto.TeamResponseDTO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface TeamRepository extends JpaRepository<Team,Integer>,TeamRepositoryCustom {

    @Query("SELECT " +
            "new com.go.ski.team.support.dto.TeamResponseDTO(" +
            "team.teamId, team.teamName, team.teamProfileUrl, team.description, skiResort.resortName) " +
            "FROM Team team " +
            "LEFT OUTER JOIN SkiResort skiResort ON team.skiResort.resortId = skiResort.resortId " +
            "WHERE team.user.userId = :userId")
    List<TeamResponseDTO> findTeamList(Integer userId);

}
