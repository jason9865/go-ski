package com.go.ski.user.support.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class CertificateUrlVO {
    Integer certificateId;
    String certificateImageUrl;
}
