package com.go.ski.user.support.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Builder
public class CertificateUrlVO {
    Integer certificateId;
    String certificateImageUrl;
}
