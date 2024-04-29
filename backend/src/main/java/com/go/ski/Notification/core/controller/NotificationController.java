package com.go.ski.Notification.core.controller;

import com.go.ski.Notification.core.service.NotificationService;
import com.go.ski.Notification.support.dto.FcmTokenRequestDTO;
import com.go.ski.Notification.support.dto.NotificationResponseDTO;
import com.go.ski.common.response.ApiResponse;
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
@RequestMapping("/api/v1/notification")
public class NotificationController {

    private final NotificationService notificationService;

    // 토큰 발급 요청
    @PostMapping("/token")
    public ResponseEntity<ApiResponse<?>> createFcmToken(HttpServletRequest request, @RequestBody FcmTokenRequestDTO requestDTO) {
        log.info("NotificationController.createFcmToken");
        User user = (User)request.getAttribute("user");
        notificationService.registerFcmToken(user,requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    // 모든 알림 가져오기
    @GetMapping
    public ResponseEntity<ApiResponse<?>> getNotifications(HttpServletRequest request) {
        log.info("NotificationController.createFcmToken");
        User user = (User)request.getAttribute("user");
        List<NotificationResponseDTO> response = notificationService.findAllNotifications(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }


    // 알림 읽기


    // 팀 초대 요청 수락

    //

}
