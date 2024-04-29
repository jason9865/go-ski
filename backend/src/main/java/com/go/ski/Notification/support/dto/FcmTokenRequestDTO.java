package com.go.ski.Notification.support.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public class FcmTokenRequestDTO {

    private final String token;
    private final String tokenType; // web, mobile

}
