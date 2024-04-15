package com.ski.piq.oauth.client;

import com.ski.piq.oauth.type.OauthServerType;
import com.ski.piq.auth.model.User;

public interface OauthMemberClient {

    OauthServerType supportServer();

    User fetch(String userAgent, String code);
}