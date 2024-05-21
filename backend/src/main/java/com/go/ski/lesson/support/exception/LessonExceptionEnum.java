package com.go.ski.lesson.support.exception;

import com.go.ski.common.exception.ExceptionEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public enum LessonExceptionEnum implements ExceptionEnum {
    NO_LOGIN(HttpStatus.UNAUTHORIZED, 401, "다시 로그인해 주세요."),
    WRONG_REQUEST(HttpStatus.BAD_REQUEST, 400, "잘못된 요청입니다."),
    NO_PARAM(HttpStatus.BAD_REQUEST, 400, "데이터가 없습니다."),
    RESIGNED_USER(HttpStatus.BAD_REQUEST, 400, "탈퇴한 유저입니다.");

    private final HttpStatus status;
    private final int code;
    private final String message;
}
