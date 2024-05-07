package com.go.ski.team.support.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ResortListDTO {
	private Integer resortId;
	private String resortName;
	private String resortLocation;
	private Integer lessonTime;
}

