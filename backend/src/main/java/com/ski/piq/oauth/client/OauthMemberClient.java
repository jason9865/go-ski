package com.ski.piq.oauth.client;

import com.ski.piq.oauth.type.OauthServerType;
import com.ski.piq.user.model.User;

public interface OauthMemberClient {

    OauthServerType supportServer();

    User fetch(String code);
}