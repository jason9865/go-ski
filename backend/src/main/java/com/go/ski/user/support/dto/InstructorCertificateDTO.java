package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.CertificateVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class InstructorCertificateDTO extends ProfileImageDTO {
    private List<CertificateVO> certificateVOs;
}
