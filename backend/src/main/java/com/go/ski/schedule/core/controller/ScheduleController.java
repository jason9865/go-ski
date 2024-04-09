package com.go.ski.schedule.core.controller;

import com.go.ski.common.response.ApiResponse;
import com.go.ski.schedule.core.service.ScheduleService;
import com.go.ski.user.core.model.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RequestMapping("/api/v1/schedule")
@RestController
public class ScheduleController {
    private final ScheduleService scheduleService;

    @PostMapping("/mine")
    public ResponseEntity<ApiResponse<?>> getMySchedule(HttpServletRequest request) {
        log.info("본인 스케줄 조회");
        User user = (User) request.getAttribute("user");

        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }
}
