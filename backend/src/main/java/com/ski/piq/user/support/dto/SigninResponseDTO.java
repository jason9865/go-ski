package com.ski.piq.user.support.dto;

import com.ski.piq.user.support.vo.Gender;
import com.ski.piq.user.support.vo.Role;
import com.ski.piq.user.core.model.User;
import lombok.Getter;

@Getter
public class SigninResponseDTO {
    private String name;
    private String profileUrl;
    private Gender gender;
    private Role role;

    public SigninResponseDTO(User user) {
        name = user.getName();
        profileUrl = user.getProfileUrl();
        gender = user.getGender();
        role = user.getRole();
    }
}
