package com.go.ski.team.core.service;

import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.support.dto.TeamInstructorResponseDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TeamInstructorService {

    private final TeamInstructorRepository teamInstructorRepository;

    public List<TeamInstructorResponseDTO> getTeamInstructorList(Integer teamId) {
        return teamInstructorRepository.findTeamInstructors(teamId);
    }



}
