package com.go.ski.auth.oauth.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "oauth.kakao.student")
public record KakaoStudentOauthConfig(
        String redirectUri,
        String clientId,
        String clientSecret
) {
}
