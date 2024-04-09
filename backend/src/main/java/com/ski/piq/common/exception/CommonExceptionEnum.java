package com.ski.piq.common.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum CommonExceptionEnum implements ExceptionEnum {
    DATA_ACCESS_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, 500, "데이터베이스 오류입니다."),
    UNKNOWN_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, 500, "알 수 없는 오류입니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;
}
