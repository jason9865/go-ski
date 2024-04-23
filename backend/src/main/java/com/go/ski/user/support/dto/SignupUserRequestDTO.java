package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class SignupUserRequestDTO extends ProfileImageDTO {
    private String userName;
    private Gender gender;
    private LocalDateTime birthDate;
    private String phoneNumber;
    private Role role;
}
