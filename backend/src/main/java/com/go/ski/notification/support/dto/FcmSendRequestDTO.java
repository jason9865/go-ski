package com.go.ski.notification.support.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FcmSendRequestDTO {

    private String recipientToken;
    private String title;
    private String content;
    private MultipartFile image;
    private String type;

    @Builder
    public FcmSendRequestDTO(String recipientToken, String title, String content, MultipartFile image, String type) {
        this.recipientToken = recipientToken;
        this.title = title;
        this.content = content;
        this.image = image;
        this.type = type;
    }

}
