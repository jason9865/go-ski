package com.ski.piq.oauth.client;

import com.ski.piq.auth.core.model.User;
import com.ski.piq.oauth.type.OauthServerType;

public interface OauthMemberClient {

    OauthServerType supportServer();

    User fetch(String authCode, String accessToken);
}