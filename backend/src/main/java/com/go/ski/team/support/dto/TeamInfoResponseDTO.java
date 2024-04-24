package com.go.ski.team.support.dto;

import com.go.ski.team.support.vo.TeamImageVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import net.minidev.json.annotate.JsonIgnore;

import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
public class TeamInfoResponseDTO {

    private Integer teamId;
    private String teamName;
    private Integer resortId;
    private String teamProfileImageUrl;
    private String description;
    private Integer teamCost;
    @JsonIgnore
    private Integer dayoff;
    @Setter
    private List<Integer> dayoffList;
    @Setter
    private List<TeamImageVO> teamImages;
    private Integer intermediateFee;
    private Integer advancedFee;
    private Integer oneTwoFee;
    private Integer oneThreeFee;
    private Integer oneFourFee;
    private Integer oneNFee;


    public static List<Integer> toDayOfWeek(int dayOff) {
        List<Integer> dayOfWeek = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            if ((dayOff & (1 << i)) != 0) {
                dayOfWeek.add(i);
            }
        }
        return dayOfWeek;
    }



}
