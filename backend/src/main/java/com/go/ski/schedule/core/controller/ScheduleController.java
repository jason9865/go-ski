package com.go.ski.schedule.core.controller;

import com.go.ski.auth.exception.AuthExceptionEnum;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.payment.core.model.Lesson;
import com.go.ski.payment.core.model.LessonInfo;
import com.go.ski.schedule.core.service.ScheduleDeleteService;
import com.go.ski.schedule.core.service.ScheduleService;
import com.go.ski.schedule.support.dto.CreateScheduleRequestDTO;
import com.go.ski.schedule.support.vo.ReserveScheduleVO;
import com.go.ski.user.core.model.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/schedule")
@RestController
public class ScheduleController {
    private final ScheduleService scheduleService;
    private final ScheduleDeleteService scheduleDeleteService;

    @GetMapping("/mine")
    public ResponseEntity<ApiResponse<?>> getMySchedule(HttpServletRequest request) {
        log.info("본인 스케줄 조회");
        User user = (User) request.getAttribute("user");
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(scheduleService.getMySchedule(user)));
    }

    @GetMapping("/{teamId}/{lessonDate}")
    public ResponseEntity<ApiResponse<?>> getTeamSchedule(HttpServletRequest request, @PathVariable int teamId, @PathVariable LocalDate lessonDate) {
        log.info("팀 스케줄 조회: {}, {}", teamId, lessonDate);
        User user = (User) request.getAttribute("user");
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(scheduleService.getTeamSchedule(user, teamId, lessonDate)));
    }

    @PostMapping("/create")
    public ResponseEntity<ApiResponse<?>> createSchedule(HttpServletRequest request, @RequestBody CreateScheduleRequestDTO createScheduleRequestDTO) {
        log.info("스케줄 등록: {}", createScheduleRequestDTO);
        User user = (User) request.getAttribute("user");
        if (!scheduleService.checkAddPermission(user, createScheduleRequestDTO.getTeamId())) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.NO_ADMIN);
        }
        scheduleService.createSchedule(new ReserveScheduleVO(createScheduleRequestDTO));
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @DeleteMapping("/{lessonId}")
    public ResponseEntity<ApiResponse<?>> deleteSchedule(HttpServletRequest request, @PathVariable Integer lessonId) {
        log.info("스케줄 삭제: {}", lessonId);
        User user = (User) request.getAttribute("user");
        if (!scheduleService.checkPermission(user, lessonId, 1)) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.NO_ADMIN);
        }
        scheduleDeleteService.deleteSchedule(lessonId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    @PatchMapping("/{lessonId}")
    public ResponseEntity<ApiResponse<?>> updateSchedule(HttpServletRequest request, @PathVariable Integer lessonId, @RequestBody CreateScheduleRequestDTO createScheduleRequestDTO) {
        log.info("스케줄 수정: {}", lessonId);
        User user = (User) request.getAttribute("user");
        if (!scheduleService.checkPermission(user, lessonId, 2)) {
            throw ApiExceptionFactory.fromExceptionEnum(AuthExceptionEnum.NO_ADMIN);
        }
        scheduleService.createSchedule(new ReserveScheduleVO(lessonId, createScheduleRequestDTO));
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

}
