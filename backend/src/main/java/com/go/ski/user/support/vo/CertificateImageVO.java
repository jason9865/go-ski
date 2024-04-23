package com.go.ski.user.support.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class CertificateImageVO {
    private int certificateId;
    private MultipartFile certificateImage;
}
