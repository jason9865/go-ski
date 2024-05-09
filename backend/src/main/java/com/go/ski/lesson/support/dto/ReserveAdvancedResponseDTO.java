package com.go.ski.lesson.support.dto;

import com.go.ski.lesson.support.vo.CertificateInfoVO;
import com.go.ski.team.core.model.Permission;
import com.go.ski.user.core.model.Instructor;
import com.go.ski.user.core.model.User;
import com.go.ski.user.support.vo.Gender;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@NoArgsConstructor
@ToString
public class ReserveAdvancedResponseDTO extends ReserveResponseDTO {
    private Integer instructorId;
    private String userName;
    private Integer position;
    private String description;
    private String instructorUrl;
    private Gender gender;
    private List<CertificateInfoVO> certificateInfoVOs;

    public ReserveAdvancedResponseDTO(Instructor instructor, Permission permission, List<CertificateInfoVO> certificateInfoVOs) {
        instructorId = instructor.getInstructorId();
        userName = instructor.getUser().getUserName();
        position = permission.getPosition();
        description = instructor.getDescription();
        this.certificateInfoVOs = certificateInfoVOs;
        this.instructorUrl = instructor.getUser().getProfileUrl();
        this.gender = instructor.getUser().getGender();
    }
}
