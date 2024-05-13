package com.go.ski.user.support.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString
public class InstructorImagesDTO extends ProfileImageDTO {
    private List<String> certificateIds;
    private List<MultipartFile> certificateImages;
}
