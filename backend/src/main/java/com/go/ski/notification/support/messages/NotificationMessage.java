package com.go.ski.notification.support.messages;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;


@Getter
@Builder
public class NotificationMessage {

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
        private String title;
        private String notificationType;
        private String createdAt;
    }

}
