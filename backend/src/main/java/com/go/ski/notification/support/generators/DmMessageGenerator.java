package com.go.ski.notification.support.generators;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.go.ski.common.exception.ApiExceptionFactory;
import com.go.ski.notification.support.events.MessageEvent;
import com.go.ski.notification.support.exception.NotificationExceptionEnum;
import com.go.ski.notification.support.messages.DMMessage;
import com.go.ski.notification.support.messages.DMMessage.Data;

import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@RequiredArgsConstructor
public class DmMessageGenerator implements MessageGenerator{

    private final MessageEvent messageEvent;

    @Override
    public String makeMessage(String targetToken, ObjectMapper objectMapper) {

        Data data = Data.builder()
                .senderId(messageEvent.getSenderId().toString())
                .senderName(messageEvent.getSenderName())
                .title(messageEvent.getTitle())
                .content(messageEvent.getContent())
                .imageUrl(messageEvent.getImageUrl())
                .notificationType(messageEvent.getNotificationType().toString())
                .createdAt(LocalDateTime.now().format(DATE_TIME_FORMATTER))
                .build();



        DMMessage dmMessage = DMMessage.builder()
                .message(new DMMessage.Message(data,targetToken))
                .validateOnly(VALIDATE_ONLY).build();

        try {
            return objectMapper.writeValueAsString(dmMessage);
        } catch (JsonProcessingException e) {
            throw ApiExceptionFactory.fromExceptionEnum(NotificationExceptionEnum.CONVERTING_JSON_ERROR);
        }
    }
}
