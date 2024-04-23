package com.go.ski.team.support.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

@Getter
@AllArgsConstructor
@Builder
public class TeamImageVO {

    private Integer teamImageId;
    private String imageUrl;

}
