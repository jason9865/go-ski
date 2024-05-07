package com.go.ski.team.support.dto;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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
	private List<Integer> lessonTime;

	public ResortListDTO(Integer resortId, String resortLocation, String resortName, Object lessonTime) {
		this.resortId = resortId;
		this.resortLocation = resortLocation;
		this.resortName = resortName;

		// lessonTime을 문자열로 변환하고 쉼표(,)로 분할하여 리스트로 변환
		String lessonTimeString = lessonTime.toString();
		this.lessonTime = Arrays.stream(lessonTimeString.split(","))
			.map(Integer::parseInt)
			.collect(Collectors.toList());
	}
}

