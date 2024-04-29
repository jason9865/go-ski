package com.go.ski.lesson.support.vo;

import com.go.ski.user.core.model.InstructorCert;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class CertificateInfoVO {
    private Integer certificateId;
    private String certificateName;
    private String certificateType;
    private String certificateImageUrl;

    public CertificateInfoVO(InstructorCert instructorCert) {
        setCertificateId(instructorCert.getCertificate().getCertificateId());
        setCertificateName(instructorCert.getCertificate().getCertificateName());
        setCertificateType(instructorCert.getCertificate().getCertificateType());
        setCertificateImageUrl(instructorCert.getCertificateImageUrl());
    }
}
