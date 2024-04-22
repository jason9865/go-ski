package com.go.ski.team.support.dto;

import lombok.Getter;
import org.springframework.web.multipart.MultipartFile;

@Getter
public class TeamImageRequestDTO {

    private MultipartFile image;

}
