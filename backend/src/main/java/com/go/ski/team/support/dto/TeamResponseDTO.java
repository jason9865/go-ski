package com.go.ski.team.support.dto;

import com.go.ski.team.support.vo.TeamImageVO;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
public class TeamResponseDTO {

    private Integer teamId;
    private String teamName;
    private Integer resortId;
    private String teamProfileImageUrl;
    private String description;
    private Integer teamCost;
    private List<Integer> dayOffs;
    private List<TeamImageVO> teamImages;
    private Integer intermediateFee;
    private Integer advancedFee;
    private Integer oneTwoFee;
    private Integer oneThreeFee;
    private Integer oneFourFee;
    private Integer oneNFee;




}
