package com.go.ski.user.support.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SigninRequestDTO {
    private String role;
    private String code;
    private String token;
}
