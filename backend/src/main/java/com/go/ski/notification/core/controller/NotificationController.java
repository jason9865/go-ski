package com.go.ski.notification.core.controller;

import com.go.ski.notification.core.service.NotificationService;
import com.go.ski.notification.support.dto.*;
import com.go.ski.common.response.ApiResponse;
import com.go.ski.team.core.service.TeamInstructorService;
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
    private final TeamInstructorService teamInstructorService;

    // 토큰 발급 요청
    @PostMapping("/token")
    public ResponseEntity<ApiResponse<?>> createFcmToken(HttpServletRequest request, @RequestBody FcmTokenRequestDTO requestDTO) {
        log.info("NotificationController.createFcmToken");
        User user = (User) request.getAttribute("user");
        notificationService.registerFcmToken(user, requestDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(ApiResponse.success(null));
    }

    // 모든 알림 가져오기
    @GetMapping
    public ResponseEntity<ApiResponse<?>> getNotifications(HttpServletRequest request) {
        log.info("NotificationController.getNotifications");
        log.info("User-Agent - {}.", request.getHeader("User-Agent"));
        log.info("DeviceType - {}.", request.getHeader("DeviceType"));
        User user = (User) request.getAttribute("user");
        List<NotificationResponseDTO> response = notificationService.findAllNotifications(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(response));
    }


    // 알림 읽기
    @PatchMapping("/read-all")
    public ResponseEntity<ApiResponse<?>> readNotifications(HttpServletRequest request) {
        log.info("NotificationController.readNotifications");
        User user = (User) request.getAttribute("user");
        notificationService.readAll(user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    // 알림 삭제
    @DeleteMapping("/delete/{notificationId}")
    public ResponseEntity<ApiResponse<?>> deleteNotification(HttpServletRequest request, @PathVariable Integer notificationId) {
        log.info("NotificationController.deleteNotification");
        User user = (User) request.getAttribute("user");
        notificationService.delete(notificationId, user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    // 메시지 보내기
    @PostMapping("/dm")
    public ResponseEntity<ApiResponse<?>> sendMessage(HttpServletRequest request, FcmSendRequestDTO requestDTO) {
        log.info("NotificationController.sendMessage");
        notificationService.sendMessage(requestDTO, request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success("메시지 전송을 완료했습니다."));
    }

    //팀 초대 요청
    @PostMapping("/invite")
    public ResponseEntity<ApiResponse<?>> requestInvite(HttpServletRequest request, @RequestBody InviteRequestDTO requestDTO) {
        log.info("NotificationController.requestInvite");
        notificationService.sendInvite(requestDTO, request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success("초대 요청을 전송하였습니다."));
    }

    // 팀 초대 요청 수락
    @PostMapping("/accept-invite")
    public ResponseEntity<ApiResponse<?>> acceptInvite(HttpServletRequest request, @RequestBody InviteAcceptRequestDTO requestDTO) {
        log.info("NotificationController.acceptInvite");
        teamInstructorService.addNewInstructor(requestDTO, request);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }

    // 알림 권한 수정
    @PatchMapping("/setting")
    public ResponseEntity<ApiResponse<?>> setNotification(HttpServletRequest request,
                                                          @RequestBody NotificationSettingRequestDTO requestDTO) {
        log.info("NotificationController.setNotification");
        User user = (User) request.getAttribute("user");
        notificationService.setNotifications(requestDTO, user);
        return ResponseEntity.status(HttpStatus.OK).body(ApiResponse.success(null));
    }
}
