package com.go.ski.team.support.dto;

import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.User;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Getter
@Setter
@ToString
public class TeamUpdateRequestDTO {

    private String teamName;
    private Integer resortId;
    private String description;
    private Integer teamCost;
    private List<Integer> dayoff;
    private List<Integer> deleteTeamImageIds;
    private Integer intermediateFee;
    private Integer advancedFee;
    private Integer oneTwoFee;
    private Integer oneThreeFee;
    private Integer oneFourFee;
    private Integer oneNFee;


}
