package com.go.ski.notification.core.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.core.domain.DeviceType;
import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.support.events.MessageEvent;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.notification.support.generators.DmMessageGenerator;
import com.go.ski.notification.support.generators.MessageGenerator;
import com.go.ski.notification.support.generators.NotificationMessageGenerator;
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
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class FcmClient {

    private static final String PREFIX_ACCESS_TOKEN = "Bearer ";
    private static final String PREFIX_FCM_REQUEST_URL = "https://fcm.googleapis.com/v1/projects/";
    private static final String POSTFIX_FCM_REQUEST_URL = "/messages:send";
    private static final String FIREBASE_KEY_PATH = "firebase/goSkiAccountKey.json";
    private static final String GOOGLE_AUTH_URL = "https://www.googleapis.com/auth/cloud-platform";

    @Value("${firebase.project.id}")
    private String projectId;

    private final ObjectMapper objectMapper;
    private final UserRepository userRepository;

    public void sendMessageTo(MessageEvent messageEvent) {
        sendMessageTo(messageEvent.getReceiverId(), messageEvent.getDeviceType(), new DmMessageGenerator(messageEvent));
    }

    public void sendMessageTo(Notification notification) {
        sendMessageTo(notification.getReceiverId(), notification.getDeviceType(), new NotificationMessageGenerator(notification));
    }

    public void sendMessageTo(Integer receiverId, DeviceType deviceType, MessageGenerator messageGenerator) {
        String targetToken = getFcmToken(receiverId, deviceType);
        String message = messageGenerator.makeMessage(targetToken, objectMapper);
        log.info("targetToken - {}",targetToken);

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
        httpHeaders.add(HttpHeaders.AUTHORIZATION, PREFIX_ACCESS_TOKEN + getAccessToken());

        HttpEntity<String> httpEntity = new HttpEntity<>(message, httpHeaders);

        String fcmRequestUrl = PREFIX_FCM_REQUEST_URL + projectId + POSTFIX_FCM_REQUEST_URL;

        ResponseEntity<String> response = restTemplate.exchange(
                fcmRequestUrl,
                HttpMethod.POST,
                httpEntity,
                String.class
        );

        log.info("FcmService - response : {}", response.getStatusCode());

        if (response.getStatusCode().isError()) {
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.FIREBASE_CONNECTION_ERROR);
        }
    }

    private String getAccessToken() {
        try {
            GoogleCredentials googleCredentials = GoogleCredentials
                    .fromStream(new ClassPathResource(FIREBASE_KEY_PATH).getInputStream())
                    .createScoped(List.of(GOOGLE_AUTH_URL));

            googleCredentials.refreshIfExpired();
            return googleCredentials.getAccessToken().getTokenValue();
        } catch (IOException e) {
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.GOOGLE_REQUEST_TOKEN_ERROR);
        }

    }

    public String getFcmToken(Integer userId, DeviceType type) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> ApiExceptionFactory.fromExceptionEnum(UserExceptionEnum.NO_PARAM));
        return type.equals(DeviceType.WEB) ? user.getFcmWeb() : user.getFcmMobile();
    }

}
