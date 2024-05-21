package com.go.ski.auth.oauth.client;

import com.go.ski.auth.oauth.type.OauthServerType;
import com.go.ski.user.core.model.User;

public interface OauthMemberClient {

    OauthServerType supportServer();

    User fetch(String role, String authCode, String accessToken);
}