package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.TeamImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface TeamImageRepository extends JpaRepository<TeamImage, Integer> {

    @Query("SELECT ti FROM TeamImage ti WHERE ti.team.teamId = :teamId")
    List<TeamImage> findByTeamId(Integer teamId);

}
