package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.CertificateUrlVO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ProfileInstructorResponseDTO extends ProfileUserResponseDTO {
    private List<CertificateUrlVO> certificateUrlVOs;

    public ProfileInstructorResponseDTO(ProfileUserResponseDTO profileUserResponseDTO, List<CertificateUrlVO> certificateUrlVOs) {
        super(profileUserResponseDTO);
        this.certificateUrlVOs = certificateUrlVOs;
    }
}
