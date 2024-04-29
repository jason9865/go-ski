package com.go.ski.Notification.support.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class FcmSendDTO {

    private String token;
    private String title;
    private String content;
    private MultipartFile image;

}
