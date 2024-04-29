package com.go.ski.user.support.dto;

import com.go.ski.user.support.vo.CertificateUrlVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class UpdateInstructorRequestDTO extends InstructorImagesDTO {
    private String description;
    private String lessonType;
    private Integer dayoff;
    private List<CertificateUrlVO> deleteCertificateUrls;
}
