package com.go.ski.notification.core.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.common.util.S3Uploader;
import com.go.ski.notification.support.dto.FcmMessageDTO;
import com.go.ski.notification.support.dto.FcmSendRequestDTO;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.google.auth.oauth2.GoogleCredentials;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class FcmService {

    private static final String PREFIX_ACCESS_TOKEN = "Bearer ";
    private static final String PREFIX_FCM_REQUEST_URL = "https://fcm.googleapis.com/v1/projects/";
    private static final String POSTFIX_FCM_REQUEST_URL = "/messages:send";
    private static final String FIREBASE_KEY_PATH = "goSkiAccountKey.json";
    private static final String GOOGLE_AUTH_URL ="https://www.googleapids.com/auth/cloud-platform";

    @Value("${firebase.project.id}")
    private String projectId;

    private final S3Uploader s3Uploader;

    public Integer sendMessageTo(FcmSendRequestDTO fcmSendRequestDTO) {
        String message = makeMessage(fcmSendRequestDTO);
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

        return response.getStatusCode() == HttpStatus.OK ? 1 : 0;
    }

    private String makeMessage(FcmSendRequestDTO fcmSendRequestDTO) {

        ObjectMapper objectMapper = new ObjectMapper();

        FcmMessageDTO fcmMessageDTO = FcmMessageDTO.builder()
                .message(FcmMessageDTO.Message.builder()
                        .token(fcmSendRequestDTO.getRecipientToken())
                        .data(FcmMessageDTO.Data.builder()
                                .title(fcmSendRequestDTO.getTitle())
                                .content(fcmSendRequestDTO.getContent())
                                .imageUrl(null)
                                .build()
                            ).build()).validateOnly(false).build();

        try {
            return objectMapper.writeValueAsString(fcmMessageDTO);
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

}
