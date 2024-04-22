package com.go.ski.user.support.vo;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class CertificateVO {
    private int certificateId;
    private MultipartFile certificateImage;
}
