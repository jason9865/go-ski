package com.ski.piq.auth.oauth.client;

import com.ski.piq.user.core.model.User;
import com.ski.piq.auth.oauth.type.OauthServerType;

public interface OauthMemberClient {

    OauthServerType supportServer();

    User fetch(String authCode, String accessToken);
}