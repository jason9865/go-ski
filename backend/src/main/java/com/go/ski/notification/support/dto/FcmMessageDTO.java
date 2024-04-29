package com.go.ski.notification.support.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;


@Getter
@Builder
public class FcmMessageDTO {

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
        private String content;
        private String imageUrl;
    }

}
