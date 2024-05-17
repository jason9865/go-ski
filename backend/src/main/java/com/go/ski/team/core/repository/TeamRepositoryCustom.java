package com.go.ski.team.core.repository;

import com.go.ski.team.support.dto.TeamInfoResponseDTO;

import java.util.Optional;

public interface TeamRepositoryCustom {

    Optional<TeamInfoResponseDTO> findTeamInfo(Integer teamId);

}
