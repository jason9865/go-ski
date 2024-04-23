package com.go.ski.team.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum TeamExceptionEnum implements ExceptionEnum {

    TEAM_NOT_FOUND(HttpStatus.NOT_FOUND,404,"해당 팀이 존재하지 않습니다!");

    private final HttpStatus status;
    private final int code;
    private final String message;

}
