package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;

@Getter
@Setter
@ToString
public class SignupInstructorRequestDTO extends InstructorImagesDTO {
    private String userName;
    private Gender gender;
    private LocalDate birthDate;
    private String phoneNumber;
    private Role role;
    private String lessonType;
    private String domainUserKey;
    private String kakaoProfileUrl;
}