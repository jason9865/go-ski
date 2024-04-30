package com.go.ski.notification.core.controller;

import com.go.ski.notification.core.service.FcmService;
import com.go.ski.notification.core.service.NotificationService;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.notification.support.dto.FcmTokenRequestDTO;
import com.go.ski.notification.support.dto.InviteRequestDTO;
import com.go.ski.notification.support.dto.NotificationResponseDTO;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.user.core.model.User;
import com.google.protobuf.Api;
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
    private final FcmService fcmService;

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
    @PatchMapping("/{notificationId}/read")
    public ResponseEntity<ApiResponse<?>> readNotifications(@PathVariable Integer notificationId ){
        log.info("NotificationController.readNotifications");
        notificationService.read(notificationId);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    // 알림 보내기
    @PostMapping("/send")
    public ResponseEntity<ApiResponse<?>> sendMessage(FcmSendRequestDTO requestDTO) {
        log.info("NotificationController.sendMessage");
        fcmService.sendMessageTo(requestDTO);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    // 팀 초대 요청 수락
    @PostMapping("/invite-accept")
    public ResponseEntity<ApiResponse<?>> acceptInvite(@RequestBody InviteRequestDTO requestDTO) {
        log.info("NotificationController.acceptInvite");
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }
}
