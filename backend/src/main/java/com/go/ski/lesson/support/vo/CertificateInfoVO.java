package com.go.ski.lesson.support.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CertificateInfoVO {
    private Integer certificateId;
    private String certificateName;
    private String certificateType;
    private String certificateImageUrl;
}
