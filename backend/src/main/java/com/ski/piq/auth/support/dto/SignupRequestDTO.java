package com.ski.piq.auth.support.dto;

import com.ski.piq.auth.support.vo.Certificate;
import com.ski.piq.auth.support.vo.Gender;
import com.ski.piq.auth.support.vo.Role;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
public class SignupRequestDTO {
    private String name;
    private MultipartFile profileImage;
    private Gender gender;
    private Timestamp birthDate;
    private String phoneNumber;
    private Role role;
    private List<Certificate> certificates;
}