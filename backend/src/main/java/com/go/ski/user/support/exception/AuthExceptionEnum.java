package com.go.ski.user.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum AuthExceptionEnum implements ExceptionEnum {
    NO_LOGIN(HttpStatus.UNAUTHORIZED, 401, "다시 로그인해 주세요"),
    NO_ADMIN(HttpStatus.FORBIDDEN, 403, "권한이 없는 사용자입니다"),
    WRONG_CODE(HttpStatus.BAD_REQUEST, 400, "잘못된 인가 코드입니다."),
    NEED_REFRESH_TOKEN(HttpStatus.BAD_REQUEST, 400, "리프레시 토큰이 필요합니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;
}
