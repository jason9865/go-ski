package com.ski.piq.auth.support.dto;

import com.ski.piq.auth.support.vo.Gender;
import com.ski.piq.auth.support.vo.Role;
import com.ski.piq.auth.core.model.User;
import lombok.Getter;

import java.util.UUID;

@Getter
public class SigninResponseDTO {
    private UUID uuid;
    private String name;
    private String profileUrl;
    private Gender gender;
    private Role role;

    public SigninResponseDTO(User user) {
        uuid = user.getUuid();
        name = user.getName();
        profileUrl = user.getProfileUrl();
        gender = user.getGender();
        role = user.getRole();
    }
}
