package com.go.ski.auth.oauth.client;

import com.go.ski.auth.oauth.config.KakaoInstructorOauthConfig;
import com.go.ski.auth.oauth.config.KakaoStudentOauthConfig;
import com.go.ski.auth.oauth.dto.KakaoMemberResponse;
import com.go.ski.auth.oauth.dto.KakaoToken;
import com.go.ski.auth.oauth.type.OauthServerType;
import com.go.ski.user.core.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

@Slf4j
@Component
@RequiredArgsConstructor
public class KakaoMemberClient implements OauthMemberClient {
    private final KakaoApiClient kakaoApiClient;
    private final KakaoStudentOauthConfig kakaoStudentOauthConfig;
    private final KakaoInstructorOauthConfig kakaoInstructorOauthConfig;

    @Override
    public OauthServerType supportServer() {
        return OauthServerType.kakao;
    }

    @Override
    public User fetch(String role, String authCode, String accessToken) {
        if (authCode != null) {
            KakaoToken tokenInfo = kakaoApiClient.fetchToken(tokenRequestParams(role, authCode));
            accessToken = tokenInfo.accessToken();
        }
        log.info("accessToken: {}", accessToken);
        KakaoMemberResponse kakaoMemberResponse = kakaoApiClient.fetchMember("Bearer " + accessToken);
        return kakaoMemberResponse.toDomain();
    }

    private MultiValueMap<String, String> tokenRequestParams(String role, String authCode) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("code", authCode);
        if ("STUDENT".equals(role)) {
            params.add("client_id", kakaoStudentOauthConfig.clientId());
            params.add("redirect_uri", kakaoStudentOauthConfig.redirectUri());
            params.add("client_secret", kakaoStudentOauthConfig.clientSecret());
        } else if ("INSTRUCTOR".equals(role)) {
            params.add("client_id", kakaoInstructorOauthConfig.clientId());
            params.add("redirect_uri", kakaoInstructorOauthConfig.redirectUri());
            params.add("client_secret", kakaoInstructorOauthConfig.clientSecret());
        }
        return params;
    }
}