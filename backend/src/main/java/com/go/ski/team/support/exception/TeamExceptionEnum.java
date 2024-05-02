package com.go.ski.team.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum TeamExceptionEnum implements ExceptionEnum {

    TEAM_NOT_FOUND(HttpStatus.NOT_FOUND,400,"해당 팀이 존재하지 않습니다."),
    TEAM_INSTRUCTOR_NOT_FOUND(HttpStatus.NOT_FOUND,400,"해당 강습 팀 강사가 존재하지 않습니다."),
    TEAM_INSTRUCTOR_EXISTS(HttpStatus.BAD_REQUEST,400,"이미 해당 강습 팀에 강사가 존재합니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;

}
