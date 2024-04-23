package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@Builder
public class ProfileUserResponseDTO {
    private String userName;
    private LocalDateTime birthDate;
    private String phoneNumber;
    private String profileUrl;
    private Gender gender;
    private Role role;
}
