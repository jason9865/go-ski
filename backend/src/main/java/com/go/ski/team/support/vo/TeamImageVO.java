package com.go.ski.team.support.vo;

import com.go.ski.team.core.model.TeamImage;
import lombok.*;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class TeamImageVO {

    private Integer teamImageId;
    private String imageUrl;

    public static TeamImageVO toVO(TeamImage teamImage) {
        TeamImageVO teamImageVO = new TeamImageVO();
        teamImageVO.teamImageId = teamImage.getTeamImageId();
        teamImageVO.imageUrl = teamImage.getImageUrl();
        return teamImageVO;
    }

}
