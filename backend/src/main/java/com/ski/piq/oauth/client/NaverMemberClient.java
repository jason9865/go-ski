package com.ski.piq.oauth.client;

import com.ski.piq.auth.core.model.User;
import com.ski.piq.oauth.config.NaverOauthConfig;
import com.ski.piq.oauth.dto.NaverMemberResponse;
import com.ski.piq.oauth.dto.NaverToken;
import com.ski.piq.oauth.type.OauthServerType;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

@Component
@RequiredArgsConstructor
public class NaverMemberClient implements OauthMemberClient {

    private final NaverApiClient naverApiClient;
    private final NaverOauthConfig naverOauthConfig;

    @Override
    public OauthServerType supportServer() {
        return OauthServerType.naver;
    }

    @Override
    public User fetch(String authCode, String accessToken) {
        if (authCode != null) {
            NaverToken tokenInfo = naverApiClient.fetchToken(tokenRequestParams(authCode));
            accessToken = tokenInfo.accessToken();
        }
        NaverMemberResponse naverMemberResponse = naverApiClient.fetchMember("Bearer " + accessToken);
        return naverMemberResponse.toDomain();
    }

    private MultiValueMap<String, String> tokenRequestParams(String authCode) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", naverOauthConfig.clientId());
        params.add("client_secret", naverOauthConfig.clientSecret());
        params.add("code", authCode);
        params.add("state", naverOauthConfig.state());
        return params;
    }
}
