package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.CertificateImageVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class InstructorImagesDTO extends ProfileImageDTO {
    private List<CertificateImageVO> certificateImageVOs;
}
