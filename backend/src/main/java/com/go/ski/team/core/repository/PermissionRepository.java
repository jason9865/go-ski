package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.TeamInstructor;
import org.springframework.data.jpa.repository.JpaRepository;

import com.go.ski.team.core.model.Permission;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PermissionRepository extends JpaRepository<Permission, Integer> {

    Permission findByTeamInstructor(TeamInstructor teamInstructor);

    @Modifying
    @Query("DELETE FROM Permission p WHERE p.teamInstructor IN :teamInstructors")
    void deleteAllByTeamInstructor(List<TeamInstructor> teamInstructors);

}