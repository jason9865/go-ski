package com.go.ski.team.core.service;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.team.core.model.Permission;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.PermissionRepository;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.support.dto.TeamInstructorResponseDTO;
import com.go.ski.team.support.dto.TeamInstructorUpdateRequestDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.go.ski.team.support.exception.TeamExceptionEnum.TEAM_INSTRUCTOR_NOT_FOUND;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamInstructorService {

    private final TeamInstructorRepository teamInstructorRepository;
    private final PermissionRepository permissionRepository;

    public List<TeamInstructorResponseDTO> getTeamInstructorList(Integer teamId) {
        return teamInstructorRepository.findTeamInstructors(teamId);
    }

    public void updateTeamInstructorInfo(TeamInstructorUpdateRequestDTO request) {
        log.info("====TeamInstructorService.updateTeamInstructorInfo====");
        log.info("instructorId - {}",request.toString());
        TeamInstructor teamInstructor = teamInstructorRepository.findTeamInstructorByInstructorId(request.getInstructorId())
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TEAM_INSTRUCTOR_NOT_FOUND));

        Permission newPermission = Permission.createPermission(teamInstructor, request);
        permissionRepository.save(newPermission);
    }



}
