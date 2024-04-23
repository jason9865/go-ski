package com.go.ski.user.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class ProfileImageDTO {
    private MultipartFile profileImage;
}
