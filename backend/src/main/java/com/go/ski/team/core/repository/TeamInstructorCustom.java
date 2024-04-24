package com.go.ski.team.core.repository;

import com.go.ski.team.support.dto.TeamInstructorResponseDTO;

import java.util.List;
import java.util.Optional;

public interface TeamInstructorCustom {

    List<TeamInstructorResponseDTO> findTeamInstructors(Integer teamId);

}
