package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import com.go.ski.user.core.model.User;
import lombok.Getter;

@Getter
public class SigninResponseDTO {
    private String userName;
    private String profileUrl;
    private Gender gender;
    private Role role;

    public SigninResponseDTO(User user) {
        userName = user.getUserName();
        profileUrl = user.getProfileUrl();
        gender = user.getGender();
        role = user.getRole();
    }
}
