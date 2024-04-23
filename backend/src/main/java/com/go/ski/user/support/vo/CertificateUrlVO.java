package com.go.ski.user.support.vo;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class CertificateUrlVO {
    int certificateId;
    String certificateImageUrl;
}
