package com.go.ski.team.support.dto;

import lombok.Getter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
public class TeamCreateRequestDTO {

    private String teamName;
    private String resortId;
    private MultipartFile teamProfileImage;
    private String description;
    private Integer teamCost;
    private List<Integer> dayoff;
    private List<TeamImageRequestDTO> teamImages;
    private Integer intermediateFee;
    private Integer advancedFee;
    private Integer oneTwoFee;
    private Integer oneThreeFee;
    private Integer oneFourFee;
    private Integer oneNFee;

}
