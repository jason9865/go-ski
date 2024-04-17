package com.ski.piq.auth.support.vo;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
public class Certificate {
    private int certificateId;
    private MultipartFile certificateImage;
}
