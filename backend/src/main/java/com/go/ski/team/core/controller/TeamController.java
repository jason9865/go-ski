package com.go.ski.team.core.controller;

import com.go.ski.auth.jwt.util.JwtUtil;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.team.core.service.TeamService;
import com.go.ski.team.support.dto.TeamCreateRequestDTO;
import io.jsonwebtoken.Jwt;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/team")
public class TeamController {

    private final TeamService teamService;
    private final JwtUtil jwtUtil;

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> createTeam( TeamCreateRequestDTO requestDTO) {
        log.info("=====TeamController.createTeam=====");
        teamService.createTeam(requestDTO);
        log.info("=====팀 생성 완료=====");
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

}
