package com.go.ski.schedule.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum ScheduleExceptionEnum implements ExceptionEnum {
    NOT_MEMBER_OF_TEAM(HttpStatus.BAD_REQUEST, 400, "해당 팀의 멤버가 아닙니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;
}
