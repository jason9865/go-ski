package com.go.ski.user.user.support.dto;

import com.go.ski.user.user.support.vo.Certificate;
import com.go.ski.user.user.support.vo.Gender;
import com.go.ski.user.user.support.vo.Role;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
public class SignupRequestDTO {
    private String userName;
    private MultipartFile profileImage;
    private Gender gender;
    private Timestamp birthDate;
    private String phoneNumber;
    private Role role;
    private List<Certificate> certificates;
}