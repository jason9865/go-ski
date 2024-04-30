package com.go.ski.notification.support.dto;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.go.ski.notification.core.domain.NotificationType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;


@Getter
@Builder
public class FcmMessageDTO {

    @JsonProperty("validate_only")
    private boolean validateOnly;
    private Message message;

    @Builder
    @AllArgsConstructor
    @Getter
    public static class Message{
        private Data data;
        private String token;
    }


    @Builder
    @AllArgsConstructor
    @Getter
    public static class Data{
        private Integer senderId;
        private String senderName;
        private String title;
        private String content;
        private String imageUrl;
        private NotificationType notificationType;
    }

}
