package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.CertificateVO;
import com.go.ski.user.support.vo.Gender;
import com.go.ski.user.support.vo.Role;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@ToString
public class SignupRequestDTO {
    private String userName;
    private MultipartFile profileImage;
    private Gender gender;
    private LocalDateTime birthDate;
    private String phoneNumber;
    private Role role;
    private List<CertificateVO> certificateVOs;
}