package com.go.ski.notification.core.service;

import com.go.ski.common.util.S3Uploader;
import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.core.repository.NotificationRepository;
import com.go.ski.notification.support.EventPublisher;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.notification.support.dto.FcmTokenRequestDTO;
import com.go.ski.notification.support.dto.NotificationResponseDTO;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.exception.UserExceptionEnum;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.EventListener;
import java.util.List;

import static com.go.ski.common.constant.FileUploadPath.NOTIFICATION_IMAGE_PATH;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {

    private final UserRepository userRepository;
    private final EventPublisher eventPublisher;
    private final NotificationRepository notificationRepository;
    private final S3Uploader s3Uploader;

    public void registerFcmToken(User user, FcmTokenRequestDTO requestDTO) {
        String token = requestDTO.getToken();
        String tokenType = requestDTO.getTokenType();
        log.info("tokenType -> {}",tokenType);

        if (tokenType.equals("WEB")) {
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

    @Transactional
    public void read(Integer notificationId) {

        Notification notification = notificationRepository.findById(notificationId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.NOTIFICATION_NOT_FOUND));

        notification.read();
    }

    @Transactional
    public void sendMessage(FcmSendRequestDTO fcmSendRequestDTO){
        User sender = userRepository.findById(fcmSendRequestDTO.getSenderId())
                .orElseThrow(()->ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_PARAM));

        String imageUrl = fcmSendRequestDTO.getImage() != null ?
                s3Uploader.uploadFile(NOTIFICATION_IMAGE_PATH.path, fcmSendRequestDTO.getImage()) :
                null;

        eventPublisher.publish(fcmSendRequestDTO, imageUrl);
    }
}
