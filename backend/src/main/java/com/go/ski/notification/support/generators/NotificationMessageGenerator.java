package com.go.ski.notification.support.generators;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.core.domain.Notification;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.notification.support.messages.NotificationMessage;
import com.go.ski.notification.support.messages.NotificationMessage.Data;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@RequiredArgsConstructor
public class NotificationMessageGenerator implements MessageGenerator{

    private final Notification notification;
    @Override
    public String makeMessage(String targetToken, ObjectMapper objectMapper) {
        Data data = Data.builder()
                .title(notification.getTitle())
                .notificationType(notification.getNotificationType().toString())
                .createdAt(LocalDateTime.now().format(DATE_TIME_FORMATTER))
                .build();



        NotificationMessage notificationMessage = NotificationMessage.builder()
                .message(new NotificationMessage.Message(data,targetToken))
                .validateOnly(VALIDATE_ONLY).build();

        try {
            return objectMapper.writeValueAsString(notificationMessage);
        } catch (JsonProcessingException e) {
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.CONVERTING_JSON_ERROR);
        }
    }

}
