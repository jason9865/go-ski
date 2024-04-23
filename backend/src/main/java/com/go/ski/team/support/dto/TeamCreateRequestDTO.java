package com.go.ski.team.support.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString
public class TeamCreateRequestDTO {

    private String teamName;
    private Integer resortId;
    private MultipartFile teamProfileImage;
    private String description;
    private Integer teamCost;
    private List<Integer> dayoff;
    private List<MultipartFile> teamImages;
    private Integer intermediateFee;
    private Integer advancedFee;
    private Integer oneTwoFee;
    private Integer oneThreeFee;
    private Integer oneFourFee;
    private Integer oneNFee;

}
