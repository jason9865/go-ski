package com.go.ski.auth.oauth.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "oauth.kakao.instructor")
public record KakaoInstructorOauthConfig(
        String redirectUri,
        String clientId,
        String clientSecret
) {
}
