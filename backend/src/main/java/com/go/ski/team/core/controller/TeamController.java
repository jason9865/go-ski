package com.go.ski.team.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.team.core.service.TeamInstructorService;
import com.go.ski.team.core.service.TeamService;
import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import com.go.ski.team.support.dto.TeamInstructorResponseDTO;
import com.go.ski.team.support.dto.TeamResponseDTO;
import com.go.ski.team.support.dto.TeamUpdateRequestDTO;
import com.go.ski.user.core.model.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/team")
public class TeamController {

    private final TeamService teamService;
    private final TeamInstructorService teamInstructorService;

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> createTeam(HttpServletRequest request, TeamCreateRequestDTO requestDTO) {
        log.info("=====TeamController.createTeam=====");
        Integer userId = Integer.parseInt(request.getAttribute("userId").toString());
        teamService.createTeam(requestDTO,userId);
        log.info("=====팀 생성 완료=====");
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    @GetMapping("/{teamId}")
    public ResponseEntity<ApiResponse<?>> searchTeamInfo(@PathVariable Integer teamId){
        log.info("=====TeamController.searchTeamInfo=====");
        TeamResponseDTO response = teamService.getTeamInfo(teamId);
        log.info("=====팀 정보 조회 완료=====");
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PatchMapping("/update/{teamId}")
    public ResponseEntity<ApiResponse> updateTeamInfo(@PathVariable Integer teamId, HttpServletRequest request,
                                                      TeamUpdateRequestDTO requestDTO) {
        log.info("=====TeamController.updateTeamInfo=====");
        Integer userId = Integer.parseInt(request.getAttribute("userId").toString());
        log.info("userId -> {}",userId);
        teamService.updateTeamInfo(userId, teamId,requestDTO);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/member/{teamId}")
    public ResponseEntity<ApiResponse> searchTeamInstructorList(@PathVariable Integer teamId) {
        log.info("=====TeamController.searchTeamInstructorList=====");
        List<TeamInstructorResponseDTO> response = teamInstructorService.getTeamInstructorList(teamId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

}
