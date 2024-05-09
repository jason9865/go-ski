package com.go.ski.team.core.service;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.notification.support.dto.InviteAcceptRequestDTO;
import com.go.ski.team.core.model.Permission;
import com.go.ski.team.core.model.Team;
import com.go.ski.team.core.model.TeamInstructor;
import com.go.ski.team.core.repository.PermissionRepository;
import com.go.ski.team.core.repository.TeamInstructorRepository;
import com.go.ski.team.core.repository.TeamRepository;
import com.go.ski.team.support.dto.TeamInstructorResponseDTO;
import com.go.ski.team.support.dto.TeamInstructorUpdateRequestDTO;
import com.go.ski.team.support.exception.TeamExceptionEnum;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.InstructorRepository;
import com.go.ski.user.support.exception.UserExceptionEnum;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static com.go.ski.team.support.exception.TeamExceptionEnum.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamInstructorService {
    private static final Integer DEFAULT_DESIGNATED_COST = 100000;
    private static final Integer DEFAULT_POSITION = 4;

    private final TeamRepository teamRepository;
    private final InstructorRepository instructorRepository;
    private final TeamInstructorRepository teamInstructorRepository;
    private final PermissionRepository permissionRepository;
    private final EventPublisher eventPublisher;

    public List<TeamInstructorResponseDTO> getTeamInstructorList(Integer teamId) {
        return teamInstructorRepository.findByTeamId(teamId);
    }

    public void updateTeamInstructorInfo(TeamInstructorUpdateRequestDTO request) {
        log.info("====TeamInstructorService.updateTeamInstructorInfo====");
        log.info("instructorId - {}",request.toString());
        TeamInstructor teamInstructor = teamInstructorRepository.findTeamInstructorByInstructorId(request.getInstructorId())
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TEAM_INSTRUCTOR_NOT_FOUND));

        Permission newPermission = Permission.createPermission(teamInstructor, request);
        permissionRepository.save(newPermission);
    }

    @Transactional
    public void addNewInstructor(InviteAcceptRequestDTO inviteAcceptRequestDTO, HttpServletRequest request) {
        User user = (User)request.getAttribute("user");
        String deviceType = request.getHeader("DeviceType");

        Team team = getTeam(inviteAcceptRequestDTO.getTeamId());
        Instructor instructor = getInstructor(user.getUserId());

        validateIfExists(team, instructor);

        TeamInstructor teamInstructor = TeamInstructor.builder()
                .instructor(instructor)
                .team(team)
                .isInviteAccepted(true)
                .build();

        teamInstructorRepository.save(teamInstructor);

        Permission permission = Permission.builder()
                .teamInstructorId(teamInstructor.getTeamInstructorId())
                .teamInstructor(teamInstructor)
                .designatedCost(DEFAULT_DESIGNATED_COST)
                .position(DEFAULT_POSITION)
                .build();
        permissionRepository.save(permission);

        eventPublisher.publish(inviteAcceptRequestDTO, team, instructor, deviceType);
    }

    public Team getTeam(Integer teamId){
        return teamRepository.findById(teamId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(TeamExceptionEnum.TEAM_NOT_FOUND));
    }

    public Instructor getInstructor(Integer instructorId){
        return instructorRepository.findById(instructorId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.USER_NOT_FOUND));
    }

    private void validateIfExists(Team team,Instructor instructor ) {
        TeamInstructor teamInstructor = teamInstructorRepository.findByTeamAndInstructor(team, instructor)
                .orElse(null);
        if(teamInstructor != null) {
            throw ApiExceptionFactory.fromExceptionEnum(TEAM_INSTRUCTOR_EXISTS);
        }
    }


}
