package com.go.ski.lesson.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.lesson.core.service.LessonService;
import com.go.ski.lesson.support.dto.ReserveAdvancedResponseDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceResponseDTO;
import com.go.ski.lesson.support.dto.ReserveNoviceTeamRequestDTO;
import com.go.ski.lesson.support.dto.ReserveRequestDTO;
import com.go.ski.lesson.support.vo.ReserveInfoVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/lesson")
@RestController
public class LessonController {
    private final LessonService lessonService;

    @PostMapping("/reserve/novice")
    public ResponseEntity<ApiResponse<?>> getTeamsForNovice(@RequestBody ReserveRequestDTO reserveRequestDTO) {
        log.info("강습조회 - 초급(팀리스트): {}", reserveRequestDTO);
        ReserveInfoVO reserveInfoVO = new ReserveInfoVO(reserveRequestDTO);
        List<ReserveNoviceResponseDTO> reserveNoviceResponseDTOs = lessonService.getTeamsForNovice(reserveInfoVO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(reserveNoviceResponseDTOs));
    }

    @PostMapping("/reserve/advanced")
    public ResponseEntity<ApiResponse<?>> getInstructorsForAdvanced(@RequestBody ReserveRequestDTO reserveRequestDTO) {
        log.info("강습조회 - 중/상급(강사리스트): {}", reserveRequestDTO);
        Map<Integer, ReserveNoviceTeamRequestDTO> instructorsList = lessonService.getInstructorsForAdvanced(new ReserveInfoVO(reserveRequestDTO));
        List<ReserveAdvancedResponseDTO> reserveAdvancedResponseDTOs = instructorsList.entrySet().stream()
                .flatMap(entry -> lessonService.getInstructorsInTeam(entry.getKey(), entry.getValue()).stream())
                .collect(Collectors.toList());

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(reserveAdvancedResponseDTOs));
    }

    @PostMapping("/reserve/novice/{teamId}")
    public ResponseEntity<ApiResponse<?>> getInstructorsInTeam(@PathVariable int teamId, @RequestBody ReserveNoviceTeamRequestDTO reserveNoviceTeamRequestDTO) {
        log.info("강습조회 - 초급(팀원리스트): {}, {}", teamId, reserveNoviceTeamRequestDTO);
        List<ReserveAdvancedResponseDTO> reserveAdvancedResponseDTOs = lessonService.getInstructorsInTeam(teamId, reserveNoviceTeamRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(reserveAdvancedResponseDTOs));
    }

    @GetMapping("/list/user")
    public ResponseEntity<ApiResponse<?>> getUserLessonList(@PathVariable int teamId, @RequestBody ReserveNoviceTeamRequestDTO reserveNoviceTeamRequestDTO) {
        log.info("강습조회 - 초급(팀원리스트): {}, {}", teamId, reserveNoviceTeamRequestDTO);
        List<ReserveAdvancedResponseDTO> reserveAdvancedResponseDTOs = lessonService.getInstructorsInTeam(teamId, reserveNoviceTeamRequestDTO);

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(reserveAdvancedResponseDTOs));
    }
}
