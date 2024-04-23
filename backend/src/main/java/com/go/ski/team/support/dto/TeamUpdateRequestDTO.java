package com.go.ski.team.support.dto;

import com.go.ski.team.core.model.SkiResort;
import com.go.ski.team.core.model.Team;
import com.go.ski.user.core.model.User;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

import static com.go.ski.team.core.service.TeamService.dayoffListToInteger;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@ToString
public class TeamUpdateRequestDTO {

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
