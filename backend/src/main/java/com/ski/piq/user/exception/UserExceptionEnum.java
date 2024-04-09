package com.ski.piq.user.exception;

import com.ski.piq.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum UserExceptionEnum implements ExceptionEnum {
    WRONG_CODE(HttpStatus.BAD_REQUEST, 400, "잘못된 인가 코드입니다."),
    NEED_REFRESH_TOKEN(HttpStatus.BAD_REQUEST, 400, "리프레시 토큰이 필요합니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;
}
