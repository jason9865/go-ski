package com.go.ski.lesson.core.controller;

import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.lesson.core.service.LessonService;
import com.go.ski.lesson.support.dto.*;
import com.go.ski.lesson.support.exception.LessonExceptionEnum;
import com.go.ski.lesson.support.vo.ReserveInfoVO;
import com.go.ski.user.core.model.User;
import jakarta.servlet.http.HttpServletRequest;
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
        List<ReserveNoviceResponseDTO> reserveNoviceResponseDTOs = lessonService.getTeamsForNovice(new ReserveInfoVO(reserveRequestDTO));
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
    public ResponseEntity<ApiResponse<?>> getUserLessonList(HttpServletRequest request) {
        log.info("강습 내역 리스트 조회(수강생)");
        User user = (User) request.getAttribute("user");
        List<UserLessonResponseDTO> userLessonResponseDTOs = lessonService.getUserLessonList(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(userLessonResponseDTOs));
    }

    @GetMapping("/list/instructor")
    public ResponseEntity<ApiResponse<?>> getInstructorLessonList(HttpServletRequest request) {
        log.info("강습 내역 리스트 조회(강사)");
        User user = (User) request.getAttribute("user");
        List<InstructorLessonResponseDTO> instructorLessonResponseDTOs = lessonService.getInstructorLessonList(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(instructorLessonResponseDTOs));
    }

    @GetMapping("/list/head/{teamId}")
    public ResponseEntity<ApiResponse<?>> getHeadLessonList(HttpServletRequest request, @PathVariable Integer teamId) {
        log.info("강습 내역 리스트 조회(사장)");
        if (lessonService.isNotTeamBoss((User) request.getAttribute("user"), teamId)) {
            throw ApiExceptionFactory.fromExceptionEnum(LessonExceptionEnum.WRONG_REQUEST);
        }
        List<InstructorLessonResponseDTO> instructorLessonResponseDTOs = lessonService.getBossLessonList(teamId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(instructorLessonResponseDTOs));
    }

    @GetMapping("/list/head")
    public ResponseEntity<ApiResponse<?>> getHeadLessonList(HttpServletRequest request, @RequestParam("teamId") Integer teamId, @RequestParam("instId") Integer instructorId) {
        log.info("강사 강습 내역 리스트 조회(사장)");
        if (lessonService.isNotTeamBoss((User) request.getAttribute("user"), teamId)) {
            throw ApiExceptionFactory.fromExceptionEnum(LessonExceptionEnum.WRONG_REQUEST);
        }
        List<InstructorLessonResponseDTO> instructorLessonResponseDTOs = lessonService.getBossInstructorLessonList(teamId, instructorId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(instructorLessonResponseDTOs));
    }
}
