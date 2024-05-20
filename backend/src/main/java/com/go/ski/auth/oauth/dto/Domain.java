package com.go.ski.auth.oauth.dto;

import com.go.ski.auth.oauth.type.OauthServerType;
import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static jakarta.persistence.EnumType.STRING;
import static lombok.AccessLevel.PROTECTED;

@Embeddable
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = PROTECTED)
public class Domain {

    @Column(nullable = false, name = "domain_user_key")
    private String domainUserKey;

    @Enumerated(STRING)
    @Column(nullable = false, name = "domain_name")
    private OauthServerType domainName;
}