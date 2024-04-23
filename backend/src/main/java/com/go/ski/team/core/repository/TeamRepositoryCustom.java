package com.go.ski.team.core.repository;

import com.go.ski.team.support.dto.TeamResponseDTO;

import java.util.List;
import java.util.Optional;

public interface TeamRepositoryCustom {

    Optional<TeamResponseDTO> findTeamInfo(Integer teamId);

}
