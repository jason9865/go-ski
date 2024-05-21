package com.go.ski.user.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SigninRequestDTO {
    private String role;
    private String code;
    private String token;
}
