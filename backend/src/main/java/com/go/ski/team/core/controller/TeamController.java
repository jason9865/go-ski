package com.go.ski.team.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.team.core.service.TeamInstructorService;
import com.go.ski.team.core.service.TeamService;
import com.go.ski.team.support.dto.*;
import com.go.ski.user.core.model.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/team")
public class TeamController {

    private final TeamService teamService;
    private final TeamInstructorService teamInstructorService;

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> createTeam(HttpServletRequest request, TeamCreateRequestDTO requestDTO,
                                                     @RequestPart MultipartFile teamProfileImage,
                                                     @RequestPart List<MultipartFile> teamImages) {
        log.info("=====TeamController.createTeam=====");
        User user = (User) request.getAttribute("user");
        teamService.createTeam(user,requestDTO, teamProfileImage, teamImages);
        log.info("=====팀 생성 완료=====");
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    @GetMapping("/{teamId}")
    public ResponseEntity<ApiResponse<?>> searchTeamInfo(@PathVariable Integer teamId){
        log.info("=====TeamController.searchTeamInfo=====");
        TeamInfoResponseDTO response = teamService.getTeamInfo(teamId);
        log.info("=====팀 정보 조회 완료=====");
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PatchMapping("/update/{teamId}")
    public ResponseEntity<ApiResponse<?>> updateTeamInfo(@PathVariable Integer teamId, HttpServletRequest request,
                                                         TeamUpdateRequestDTO requestDTO,
                                                         @RequestPart MultipartFile teamProfileImage,
                                                         @RequestPart List<MultipartFile>  newTeamImages) {
        log.info("=====TeamController.updateTeamInfo=====");
        User user = (User) request.getAttribute("user");
        teamService.updateTeamInfo(user, teamId,requestDTO,teamProfileImage,newTeamImages);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @GetMapping("/member/{teamId}")
    public ResponseEntity<ApiResponse<?>> searchTeamInstructorList(@PathVariable Integer teamId) {
        log.info("=====TeamController.searchTeamInstructorList=====");
        List<TeamInstructorResponseDTO> response = teamInstructorService.getTeamInstructorList(teamId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/list/owner")
    public ResponseEntity<ApiResponse<?>> searchOwnerTeamList(HttpServletRequest request) {
        log.info("====TeamController.searchOwnerTeamList====");
        User user = (User) request.getAttribute("user");
        List<TeamResponseDTO> response = teamService.getOwnerTeamList(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @GetMapping("/list/inst")
    public ResponseEntity<ApiResponse<?>> searchInstTeamList(HttpServletRequest request) {
        log.info("====TeamController.searchInstTeamList====");
        User user = (User) request.getAttribute("user");
        List<TeamResponseDTO> response = teamService.getInstTeamList(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }

    @PatchMapping("/update/member")
    public ResponseEntity<ApiResponse<?>> updateInstructor(@RequestBody TeamInstructorUpdateRequestDTO requestDTO) {
        log.info("====TeamController.searchTeamList====");
        teamInstructorService.updateTeamInstructorInfo(requestDTO);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @DeleteMapping("/delete/{teamId}")
    public ResponseEntity<ApiResponse<?>> removeTeam(@PathVariable Integer teamId){
        log.info("====TeamController.deleteTeam====");
        teamService.deleteTeam(teamId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

}
