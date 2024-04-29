package com.go.ski.Notification.core.service;

import com.go.ski.Notification.core.domain.Notification;
import com.go.ski.Notification.core.repository.NotificationRepository;
import com.go.ski.Notification.support.dto.FcmTokenRequestDTO;
import com.go.ski.Notification.support.dto.NotificationResponseDTO;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.exception.UserExceptionEnum;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {

    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;

    public void registerFcmToken(User user, FcmTokenRequestDTO requestDTO) {
        String token = requestDTO.getToken();
        String tokenType = requestDTO.getTokenType();
        log.info("tokenType -> {}",tokenType);

        if (tokenType.equals("web")) {
            user.updateFcmWeb(token);
        }
        else {
            user.updateFcmMobile(token);
        }
        userRepository.save(user);
    }

    public List<NotificationResponseDTO> findAllNotifications(User user) {
        return notificationRepository.findByReceiverId(user.getUserId());

    }
}
