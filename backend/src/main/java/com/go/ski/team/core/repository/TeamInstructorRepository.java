package com.go.ski.team.core.repository;

import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.user.core.model.Instructor;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeamInstructorRepository extends JpaRepository<TeamInstructor, Integer>, TeamInstructorCustom {

    @Query("SELECT ti " +
            "FROM TeamInstructor ti " +
            "WHERE ti.instructor.user.userId = :instructorId")
    Optional<TeamInstructor> findTeamInstructorByInstructorId(Integer instructorId);

}
