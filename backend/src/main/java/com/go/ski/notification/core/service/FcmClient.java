package com.go.ski.notification.core.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.core.repository.NotificationRepository;
import com.go.ski.notification.support.dto.NotificationMessage;
import com.go.ski.notification.support.dto.NotificationMessage.Data;
import com.go.ski.notification.support.dto.NotificationMessage.Message;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.exception.UserExceptionEnum;
import com.google.auth.oauth2.GoogleCredentials;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static com.go.ski.common.constant.FileUploadPath.NOTIFICATION_IMAGE_PATH;

@Slf4j
@RequiredArgsConstructor
@Service
public class FcmClient {

    private static final String PREFIX_ACCESS_TOKEN = "Bearer ";
    private static final String PREFIX_FCM_REQUEST_URL = "https://fcm.googleapis.com/v1/projects/";
    private static final String POSTFIX_FCM_REQUEST_URL = "/messages:send";
    private static final String FIREBASE_KEY_PATH = "firebase/goSkiAccountKey.json";
    private static final String GOOGLE_AUTH_URL ="https://www.googleapis.com/auth/cloud-platform";

    private static final boolean VALIDATE_ONLY = false;

    DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy:MM:dd:HH:mm:ss");

    @Value("${firebase.project.id}")
    private String projectId;

    private final S3Uploader s3Uploader;
    private final UserRepository userRepository;
    private final NotificationRepository notificationRepository;

    @Transactional
    public void sendMessageTo(Notification notification) {
        log.info("FcmClient - sendMessageTo");
        String message = makeMessage(notification);
        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
        httpHeaders.add(HttpHeaders.AUTHORIZATION, PREFIX_ACCESS_TOKEN + getAccessToken());

        HttpEntity<String> httpEntity = new HttpEntity<>(message,httpHeaders);

        String fcmRequestUrl = PREFIX_FCM_REQUEST_URL + projectId + POSTFIX_FCM_REQUEST_URL;

        ResponseEntity<String> response = restTemplate.exchange(
            fcmRequestUrl,
            HttpMethod.POST,
            httpEntity,
            String.class
        );

        log.info("FcmService - response : {}",response.getStatusCode());

        if(response.getStatusCode().isError()){
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.FIREBASE_CONNECTION_ERROR);
        }


    }

    @Transactional
    public String makeMessage(Notification notification) {
        User sender = notification.getSenderId() != null ? userRepository.findById(notification.getSenderId())
                .orElseThrow(()->ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_PARAM)) : null;

        String senderId = sender != null ? sender.getUserId().toString() : null;
        String senderName = sender != null ? sender.getUserName() : null;

        Data data = Data.builder()
                .senderId(senderId)
                .senderName(senderName)
                .title(notification.getTitle())
                .content(notification.getContent())
                .imageUrl(notification.getImageUrl())
                .notificationType(notification.getNotificationType().toString())
                .createdAt(LocalDateTime.now().format(DATE_TIME_FORMATTER))
                .build();

        String targetToken = getFcmToken(notification.getReceiverId(), notification.getDeviceType());


        NotificationMessage notificationMessage = NotificationMessage.builder()
                .message(new Message(data,targetToken))
                .validateOnly(VALIDATE_ONLY).build();

        ObjectMapper objectMapper = new ObjectMapper();

        try {
            return objectMapper.writeValueAsString(notificationMessage);
        } catch (JsonProcessingException e) {
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.CONVERTING_JSON_ERROR);
        }
    }

    private String getAccessToken() {
        try{
            GoogleCredentials googleCredentials =  GoogleCredentials
                    .fromStream(new ClassPathResource(FIREBASE_KEY_PATH).getInputStream())
                    .createScoped(List.of(GOOGLE_AUTH_URL));

            googleCredentials.refreshIfExpired();
            return googleCredentials.getAccessToken().getTokenValue();
        } catch(IOException e){
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.GOOGLE_REQUEST_TOKEN_ERROR);
        }

    }

    public String getFcmToken(Integer userId, DeviceType type) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_PARAM));
        return type.equals(DeviceType.WEB) ? user.getFcmWeb() : user.getFcmMobile();
    }

}
