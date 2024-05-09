package com.go.ski.user.support.dto;

import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.support.vo.CertificateUrlVO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ProfileInstructorResponseDTO extends ProfileUserResponseDTO {
    private String description;
    private Integer dayoff;
    private String available;
    private List<CertificateUrlVO> certificates;

    public ProfileInstructorResponseDTO(ProfileUserResponseDTO profileUserResponseDTO, List<CertificateUrlVO> certificateUrlVOs) {
        super(profileUserResponseDTO);
        this.certificates = certificateUrlVOs;
    }

    public ProfileInstructorResponseDTO(
            ProfileUserResponseDTO profileUserResponseDTO,
            List<CertificateUrlVO> certificateUrlVOs,
            Instructor instructor){
        super(profileUserResponseDTO);
        this.description = instructor.getDescription();
        this.dayoff = instructor.getDayoff();
        this.available = instructor.getIsInstructAvailable();
        this.certificates = certificateUrlVOs;
    }

}
